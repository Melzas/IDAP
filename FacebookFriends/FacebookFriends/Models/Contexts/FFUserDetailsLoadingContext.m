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

- (BOOL)isDetailsLoaded;

@end

@implementation FFUserDetailsLoadingContext

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)cleanup {
	self.userData = nil;
	
	[super cleanup];
}

#pragma mark -
#pragma mark Public

- (void)performLoading {
	if ([self isDetailsLoaded]) {
		[self finishLoading];
		return;
	}
	
	NSString *graphPath = [NSString stringWithFormat:kFFGraphPathFormat, self.userData.profileId];
	[self loadFromFacebookWithGraphPath:graphPath];
}

#pragma mark -
#pragma mark Private

- (BOOL)isDetailsLoaded {
	FFUserData *userData = self.userData;
	
	if (nil == userData.address || nil == userData.photo) {
		return NO;
	}
	
	return YES;
}

- (void)loadingDidFinishWithResult:(id)result error:(NSError *)error {
	FFUserData *userData = self.userData;
	
	if (error) {
		[self failLoading];
		return;
	}
	
	userData.address = result[kFFLocationKey][kFFCityNameKey];
	
	NSString *pictureUrl = result[kFFPictureKey][kFFDataKey][kFFPictureURLKey];
	userData.photo = [FFImageModel modelWithPath:pictureUrl];
	
	[self finishLoading];
}

@end
