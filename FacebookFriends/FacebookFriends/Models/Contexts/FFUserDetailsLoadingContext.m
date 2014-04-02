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

- (void)loadFromFile;

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
	NSString *graphPath = [NSString stringWithFormat:kFFGraphPathFormat, self.userData.profileId];
	[self loadFromFacebookWithGraphPath:graphPath];
}

#pragma mark -
#pragma mark Private

- (void)loadFromFile {
	FFUserData *userData = self.userData;
	
	if (nil == userData.address || nil == userData.photo) {
		[self failLoading];
		return;
	}
	
	[self finishLoading];
}

- (void)loadingDidFinishWithResult:(id)result error:(NSError *)error {
	FFUserData *userData = self.userData;
	
	if (error) {
		[self loadFromFile];
		return;
	}
	
	userData.address = result[kFFLocationKey][kFFCityNameKey];
	
	NSString *pictureUrl = result[kFFPictureKey][kFFDataKey][kFFPictureURLKey];
	userData.photo = [FFImageModel modelWithPath:pictureUrl];
	
	[self finishLoading];
	
	self.requestConnection = nil;
}

@end
