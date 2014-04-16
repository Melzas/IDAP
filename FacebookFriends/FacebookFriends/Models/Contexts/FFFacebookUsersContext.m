//
//  FFUserLoadingContext.m
//  FacebookFriends
//
//  Created by Anton Rayev on 3/19/14.
//  Copyright (c) 2014 Anton Rayev. All rights reserved.
//

#import "FFFacebookUsersContext.h"

#import "FFUser.h"
#import "FFUsers.h"
#import "FFImage.h"

#import "FFDatabaseUsersContext.h"

static NSString * const kFFGraphPathForRequest = @"/me/friends?fields=first_name,last_name,picture";

static NSString * const kFFDataKey		 = @"data";
static NSString * const kFFPictureKey	 = @"picture";
static NSString * const kFFPictureURLKey = @"url";
static NSString * const kFFIDKey		 = @"id";

typedef FFUser *(^FFUserBlock)(id<FBGraphUser> facebookUser);

@interface FFFacebookUsersContext ()

- (void)fetchUsersFromDatabase;
- (void)createUsersWithFacebookData:(id)facebookData usingBlock:(FFUserBlock)block;
- (FFUser *)fillUser:(FFUser *)user withFacebookUser:(id<FBGraphUser>)facebookUserData;

@end


@implementation FFFacebookUsersContext

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)cleanup {
	self.users = nil;
	self.databaseUsersContext = nil;
	
	[super cleanup];
}

#pragma mark -
#pragma mark Public

- (void)performLoading {
	if (IDPModelFinished == self.users.state) {
		[self finishLoading];
		return;
	}
	
	[self loadWithGraphPath:kFFGraphPathForRequest];
}

#pragma mark -
#pragma mark Private

- (void)loadingDidFinishWithResult:(id)result error:(NSError *)error {
	if (error) {
		[self failLoading];
		return;
	}
	
	[self fetchUsersFromDatabase];
	
	__block FFUsers *usersData = self.users;
	__block NSUInteger userIndex = 0;
	
	FFUserBlock createBlock = ^FFUser *(id<FBGraphUser> facebookUser) {
		FFUser *user = [FFUser managedObject];
		[usersData addUser:user];
		
		return user;
	};
	
	FFUserBlock findOrCreateBlock = ^FFUser *(id<FBGraphUser> facebookUser) {
		FFUser *user = usersData.users[userIndex];
		
		if(![user.profileID isEqualToString:facebookUser.id]) {
			createBlock(facebookUser);
		} else {
			++userIndex;
		}
		
		return user;
	};
	
	if (0 == [usersData.users count]) {
		[self createUsersWithFacebookData:result usingBlock:createBlock];
	} else {
		[self createUsersWithFacebookData:result usingBlock:findOrCreateBlock];
	}
	
	[self finishLoading];
}

- (void)fetchUsersFromDatabase {
	FFDatabaseUsersContext *databaseLoadingContext = self.databaseUsersContext;
	databaseLoadingContext.users = self.users;
	[databaseLoadingContext load];
}

- (void)createUsersWithFacebookData:(id)facebookData usingBlock:(FFUserBlock)block {
	NSSortDescriptor *sortDescriptor = [[[NSSortDescriptor alloc] initWithKey:kFFIDKey
																    ascending:YES] autorelease];
	NSArray *friends = [facebookData[kFFDataKey] sortedArrayUsingDescriptors:@[sortDescriptor]];
	
	for (NSDictionary<FBGraphUser> *friend in friends) {
		FFUser *user = block(friend);
		
		[self fillUser:user withFacebookUser:friend];
		[user finishLoading];
	}
}

- (FFUser *)fillUser:(FFUser *)user withFacebookUser:(id<FBGraphUser>)facebookUserData {
	user.profileID = facebookUserData.id;
	user.firstName = facebookUserData.first_name;
	user.lastName = facebookUserData.last_name;
	
	NSString *pictureUrl = facebookUserData[kFFPictureKey][kFFDataKey][kFFPictureURLKey];
	user.photoPreview = [FFImage managedObjectWithPath:pictureUrl];
	[user finishLoading];
	
	return user;
}

#pragma mark -
#pragma mark IDPModel

- (void)finishLoading {
	[self.users finishLoading];
	
	[super finishLoading];
}

@end
