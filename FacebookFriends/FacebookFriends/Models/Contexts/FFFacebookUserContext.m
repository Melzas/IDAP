//
//  FFUserDetailsLoadingContext.m
//  FacebookFriends
//
//  Created by Anton Rayev on 3/27/14.
//  Copyright (c) 2014 Anton Rayev. All rights reserved.
//

#import "FFFacebookUserContext.h"

#import "FFUser.h"
#import "FFImage.h"

static NSString * const kFFGraphPathFormat = @"/%@?fields=location,picture.type(large)";

static NSString * const kFFLocationKey = @"location";
static NSString * const kFFCityNameKey = @"name";

static NSString * const kFFDataKey		 = @"data";
static NSString * const kFFPictureKey	 = @"picture";
static NSString * const kFFPictureURLKey = @"url";

@interface FFFacebookUserContext ()

- (BOOL)isDetailsLoaded;

@end

@implementation FFFacebookUserContext

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)cleanup {
	self.user = nil;
	
	[super cleanup];
}

#pragma mark -
#pragma mark Public

- (void)performLoading {
	if ([self isDetailsLoaded]) {
		[self finishLoading];
		return;
	}
	
	NSString *graphPath = [NSString stringWithFormat:kFFGraphPathFormat, self.user.profileID];
	[self loadWithGraphPath:graphPath];
}

#pragma mark -
#pragma mark Private

- (BOOL)isDetailsLoaded {
	FFUser *user = self.user;
	
	if (nil == user.address || nil == user.photo) {
		return NO;
	}
	
	return YES;
}

- (void)loadingDidFinishWithResult:(id)result {
	FFUser *user = self.user;
	
	user.address = result[kFFLocationKey][kFFCityNameKey];
	NSString *pictureUrl = result[kFFPictureKey][kFFDataKey][kFFPictureURLKey];
	user.photo = [FFImage managedObjectWithPath:pictureUrl];
	
	[self finishLoading];
}

- (void)loadingDidFail {
	[self failLoading];
}

@end
