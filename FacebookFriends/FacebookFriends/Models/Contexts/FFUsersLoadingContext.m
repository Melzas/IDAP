//
//  FFUserLoadingContext.m
//  FacebookFriends
//
//  Created by Anton Rayev on 3/19/14.
//  Copyright (c) 2014 Anton Rayev. All rights reserved.
//

#import "FFUsersLoadingContext.h"

#import "FFUserData.h"
#import "FFUsersData.h"
#import "FFImageModel.h"

static NSString * const kFFGraphPathForRequest = @"/me/friends?fields=first_name,last_name,picture";

static NSString * const kFFDataKey		 = @"data";
static NSString * const kFFPictureKey	 = @"picture";
static NSString * const kFFPictureURLKey = @"url";

@interface FFUsersLoadingContext ()
@property (nonatomic, retain)	FBRequestConnection *requestConnection;

- (void)loadFromLocalCache;
- (void)loadFromFacebook;

@end

@implementation FFUsersLoadingContext

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)cleanup {
	self.usersData = nil;
	self.requestConnection = nil;
}

#pragma mark -
#pragma mark Public

- (void)performLoading {
	[self loadFromFacebook];
}

- (void)cancel {
	[self.requestConnection cancel];
	
	[super cancel];
}

#pragma mark -
#pragma mark Private

- (void)loadFromLocalCache {
	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
		FFUsersData *usersData = self.usersData;
		
		[usersData loadFromFile];
		
		NSArray *users = usersData.users;
		if (nil == users || 0 == [users count]) {
			[self failLoading];
			return;
		}
		
		for (FFUserData *userData in users) {
			[userData finishLoading];
		}
		
		[self finishLoading];
	});
}

- (void)loadFromFacebook {
	self.requestConnection = [FBRequestConnection object];
	
	__block id weakSelf = self;
	
	FBRequestHandler handler = ^(FBRequestConnection *connection, id result, NSError *error) {
		if (error) {
			[weakSelf loadFromLocalCache];
			return;
		}
		
		NSArray *friends = result[kFFDataKey];
		
		for (NSDictionary<FBGraphUser> *friend in friends) {
			FFUserData *user = [FFUserData object];
			user.profileId = friend.id;
			user.firstName = friend.first_name;
			user.lastName = friend.last_name;
			
			NSString *pictureUrl = friend[kFFPictureKey][kFFDataKey][kFFPictureURLKey];
			user.photoPreview = [FFImageModel modelWithPath:pictureUrl];
			[user finishLoading];
			
			[self.usersData addUser:user];
		}
		
		[weakSelf finishLoading];
		
		self.requestConnection = nil;
	};
	
	FBRequestConnection *requestConnection = self.requestConnection;
	FBRequest *request = [FBRequest requestForGraphPath:kFFGraphPathForRequest];
	
	[requestConnection addRequest:request completionHandler:handler];
	[requestConnection start];
}

@end
