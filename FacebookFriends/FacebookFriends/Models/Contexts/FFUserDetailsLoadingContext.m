//
//  FFUserDetailsLoadingContext.m
//  FacebookFriends
//
//  Created by Anton Rayev on 3/27/14.
//  Copyright (c) 2014 Anton Rayev. All rights reserved.
//

#import "FFUserDetailsLoadingContext.h"

#import "FFUserData.h"
#import "FFImageModel.h"

static NSString * const kFFGraphPathFormat = @"/%@?fields=location,picture.type(large)";

static NSString * const kFFLocationKey = @"location";
static NSString * const kFFCityNameKey = @"name";

static NSString * const kFFDataKey		 = @"data";
static NSString * const kFFPictureKey	 = @"picture";
static NSString * const kFFPictureURLKey = @"url";

@interface FFUserDetailsLoadingContext ()
@property (nonatomic, retain)	FBRequestConnection	*requestConnection;

- (void)loadFromLocalCache;
- (void)loadFromFacebook;

@end

@implementation FFUserDetailsLoadingContext

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)cleanup {
	self.userData = nil;
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
	FFUserData *userData = self.userData;
	
	if (nil == userData.address || nil == userData.photo) {
		[self failLoading];
		return;
	}
	
	[self finishLoading];
}

- (void)loadFromFacebook {
	self.requestConnection = [FBRequestConnection object];
	
	__block id weakSelf = self;
	
	FBRequestHandler handler = ^(FBRequestConnection *connection, id result, NSError *error) {
		FFUserData *userData = self.userData;
		
		if (error) {
			[weakSelf loadFromLocalCache];
			return;
		}
		
		userData.address = result[kFFLocationKey][kFFCityNameKey];
		
		NSString *pictureUrl = result[kFFPictureKey][kFFDataKey][kFFPictureURLKey];
		userData.photo = [FFImageModel modelWithPath:pictureUrl];
		
		[weakSelf finishLoading];
		
		self.requestConnection = nil;
	};
	
	NSString *graphPath = [NSString stringWithFormat:kFFGraphPathFormat, self.userData.profileId];
	
	FBRequestConnection *requestConnection = self.requestConnection;
	FBRequest *request = [FBRequest requestForGraphPath:graphPath];
	
	[requestConnection addRequest:request completionHandler:handler];
	[requestConnection start];
}

@end
