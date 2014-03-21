//
//  FFUserData.m
//  FacebookFriends
//
//  Created by Anton Rayev on 3/19/14.
//  Copyright (c) 2014 Anton Rayev. All rights reserved.
//

#import "FFUserData.h"

static NSString * const kFFUserFirstNameKey	= @"kFFUserFirstNameKey";
static NSString * const kFFUserLastNameKey	= @"kFFUserLastNameKey";
static NSString * const kFFUserPhotoKey		= @"kFFUserPhotoKey";

@implementation FFUserData

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)cleanup {
	self.firstName = nil;
	self.lastName = nil;
	self.photoPreview = nil;
}

#pragma mark -
#pragma mark NSCoding

- (id)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if (self) {
		self.firstName = [decoder decodeObjectForKey:kFFUserFirstNameKey];
		self.lastName = [decoder decodeObjectForKey:kFFUserLastNameKey];
		self.photoPreview = [decoder decodeObjectForKey:kFFUserPhotoKey];
	}
	
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
	[coder encodeObject:self.firstName forKey:kFFUserFirstNameKey];
	[coder encodeObject:self.lastName forKey:kFFUserLastNameKey];
	[coder encodeObject:self.photoPreview forKey:kFFUserPhotoKey];
}

@end
