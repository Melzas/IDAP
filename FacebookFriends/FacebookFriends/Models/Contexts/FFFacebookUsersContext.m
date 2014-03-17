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
#import "FFImageModel.h"

static NSString * const kFFGraphPathForRequest = @"/me/friends?fields=first_name,last_name,picture";

static NSString * const kFFDataKey		 = @"data";
static NSString * const kFFPictureKey	 = @"picture";
static NSString * const kFFPictureURLKey = @"url";

@interface FFFacebookUsersContext ()

- (void)loadFromFile;

@end

@implementation FFFacebookUsersContext

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)cleanup {
	self.users = nil;
	
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

- (void)loadFromFile {
	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
		FFUsers *usersData = self.users;
		
		[usersData load];
		
		NSArray *users = usersData.users;
		if (nil == users || 0 == [users count]) {
			[self failLoading];
			return;
		}
		
		for (FFUser *user in users) {
			[user finishLoading];
		}
		
		[self finishLoading];
	});
}

- (void)loadingDidFinishWithResult:(id)result error:(NSError *)error {
	if (error) {
		[self loadFromFile];
		return;
	}
	
	NSArray *friends = result[kFFDataKey];
	
	for (NSDictionary<FBGraphUser> *friend in friends) {
		FFUser *user = [FFUser object];
		user.profileId = friend.id;
		user.firstName = friend.first_name;
		user.lastName = friend.last_name;
		
		NSString *pictureUrl = friend[kFFPictureKey][kFFDataKey][kFFPictureURLKey];
		user.photoPreview = [FFImageModel modelWithPath:pictureUrl];
		[user finishLoading];
		
		[self.users addUser:user];
	}
	
	[self finishLoading];
}

#pragma mark -
#pragma mark IDPModel

- (void)finishLoading {
	[self.users finishLoading];
	
	[super finishLoading];
}

@end
