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

@interface FFUsersLoadingContext ()
@property (nonatomic, assign)	IDPModelState	state;
@property (nonatomic, retain)	FFUsersData		*usersData;

- (void)loadFromFile;
- (void)loadFromNetwork;

- (FFImageModel *)loadPictureFromURL:(NSString *)url;

@end

@implementation FFUsersLoadingContext

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)cleanup {
	self.usersData = nil;
}

#pragma mark -
#pragma mark Public

- (void)loadUsersToObject:(FFUsersData *)users {
	self.usersData = users;
	
	[self load];
}

#pragma mark -
#pragma mark Private

- (void)prepareForLoad {
	[self.usersData prepareForLoad];
}

- (void)performLoading {
	self.state = IDPModelLoading;
	
	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
		IDPNetworkReachability *networkReachability = [IDPNetworkReachability reachabilityWithHostName:@"facebook.com"];
		if (networkReachability.isReachable) {
			[self loadFromNetwork];
		} else {
			[self loadFromFile];
		}
	});
}

- (void)loadFromFile {
	NSArray *users = [NSKeyedUnarchiver unarchiveObjectWithFile:self.usersData.savePath];
	
	if (nil == users) {
		[self failLoading];
		return;
	}
	
	for (FFUserData *userData in users) {
		[self.usersData addUser:userData];
		[userData finishLoading];
	}
	
	[self finishLoading];
}

- (void)loadFromNetwork {
	FBRequestHandler handler = ^(FBRequestConnection *connection, id result, NSError *error) {
		if (error) {
			[self failLoading];
			return;
		}
		
		NSArray *friends = [result objectForKey:@"data"];
		
		for (NSDictionary<FBGraphUser> *friend in friends) {
			FFUserData *user = [FFUserData object];
			user.firstName = friend.first_name;
			user.lastName = friend.last_name;
			
			id pictureData = [[friend objectForKey:@"picture"] objectForKey:@"data"];
			NSString *pictureUrl = [pictureData objectForKey:@"url"];
			user.photoPreview = [self loadPictureFromURL:pictureUrl];
			[user finishLoading];
			
			[self.usersData addUser:user];
		}
		
		[self.usersData finishLoading];
	};
	
	dispatch_async(dispatch_get_main_queue(), ^{
		[FBRequestConnection startWithGraphPath:@"/me/friends?fields=first_name,last_name,picture"
									 parameters:nil
									 HTTPMethod:@"GET"
							  completionHandler:handler];
	});
}

- (FFImageModel *)loadPictureFromURL:(NSString *)url {
	FFImageModel *pictureModel = [FFImageModel modelWithPath:url];
	[pictureModel load];
	
	return pictureModel;
}

@end
