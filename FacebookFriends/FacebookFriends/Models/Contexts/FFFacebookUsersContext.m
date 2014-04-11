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

@interface FFFacebookUsersContext () <IDPModelObserver>
@property (nonatomic, retain)		FFDatabaseUsersContext	*databaseUsersContext;
@property (nonatomic, readonly)		FFUserBlock				createBlock;
@property (nonatomic, readonly)		FFUserBlock				findOrCreateBlock;
@property (nonatomic, copy)			FFUserBlock				userBlock;

- (void)fetchUsersFromDatabase;
- (void)createUsersWithFacebookData:(id)facebookData;
- (FFUser *)fillUser:(FFUser *)user withFacebookUser:(id<FBGraphUser>)facebookUser;

@end


@implementation FFFacebookUsersContext

@dynamic createBlock;
@dynamic findOrCreateBlock;

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)cleanup {
	self.users = nil;
	self.databaseUsersContext = nil;
	self.userBlock = nil;
	
	[super cleanup];
}

#pragma mark -
#pragma mark Accessors

- (void)setDatabaseUsersContext:(FFDatabaseUsersContext *)databaseUsersContext {
	IDPNonatomicRetainPropertySynthesizeWithObserver(_databaseUsersContext, databaseUsersContext);
}

- (FFUserBlock)createBlock {
	FFUserBlock createBlock = ^FFUser *(id<FBGraphUser> facebookUser) {
		FFUser *user = [FFUser managedObject];
		[self.users addUser:user];
		
		return user;
	};
	
	return [[createBlock copy] autorelease];
}

- (FFUserBlock)findOrCreateBlock {
	__block NSUInteger userIndex = 0;
	NSArray *users = self.users.models;
	
	FFUserBlock findOrCreateBlock = ^FFUser *(id<FBGraphUser> facebookUser) {
		FFUser *user = users[userIndex];
		
		if(![user.profileID isEqualToString:facebookUser.id]) {
			self.createBlock(facebookUser);
		} else {
			++userIndex;
		}
		
		return user;
	};
	
	return [[findOrCreateBlock copy] autorelease];
}

#pragma mark -
#pragma mark Public

- (void)performLoading {
	if (IDPModelFinished == self.users.state) {
		[self finishLoading];
		return;
	}
	
	self.databaseUsersContext = [FFDatabaseUsersContext object];
	[self fetchUsersFromDatabase];
}

#pragma mark -
#pragma mark Private

- (void)loadingDidFinishWithResult:(id)result {
	[self createUsersWithFacebookData:result];
	
	[self finishLoading];
	[self.users finishLoading];
}

- (void)loadingDidFail {
	if (IDPModelFailed == self.databaseUsersContext.state) {
		[self failLoading];
	} else {
		[self finishLoading];
	}
}

- (void)fetchUsersFromDatabase {
	FFDatabaseUsersContext *databaseLoadingContext = self.databaseUsersContext;
	databaseLoadingContext.users = self.users;
	[databaseLoadingContext load];
}

- (void)createUsersWithFacebookData:(id)facebookData {
	NSSortDescriptor *sortDescriptor = [[[NSSortDescriptor alloc] initWithKey:kFFIDKey
																    ascending:YES] autorelease];
	NSArray *friends = [facebookData[kFFDataKey] sortedArrayUsingDescriptors:@[sortDescriptor]];
	
	for (NSDictionary<FBGraphUser> *friend in friends) {
		FFUser *user = self.userBlock(friend);
		
		[self fillUser:user withFacebookUser:friend];
	}
}

- (FFUser *)fillUser:(FFUser *)user withFacebookUser:(id<FBGraphUser>)facebookUser {
	user.profileID = facebookUser.id;
	user.firstName = facebookUser.first_name;
	user.lastName = facebookUser.last_name;
	
	NSString *pictureUrl = facebookUser[kFFPictureKey][kFFDataKey][kFFPictureURLKey];
	user.photoPreview = [FFImage managedObjectWithPath:pictureUrl];
	[user finishLoading];
	
	return user;
}

#pragma mark -
#pragma mark IDPModelObserver

- (void)modelDidLoad:(id)model {
	self.userBlock = self.findOrCreateBlock;
	
	[self loadWithGraphPath:kFFGraphPathForRequest];
}

- (void)modelDidFailToLoad:(id)model {
	self.userBlock = self.createBlock;
	
	[self loadWithGraphPath:kFFGraphPathForRequest];
}

@end
