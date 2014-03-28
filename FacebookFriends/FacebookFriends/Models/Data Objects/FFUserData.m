//
//  FFUserData.m
//  FacebookFriends
//
//  Created by Anton Rayev on 3/19/14.
//  Copyright (c) 2014 Anton Rayev. All rights reserved.
//

#import "FFUserData.h"

static NSString * const kFFProfileIdKey		   = @"kFFProfileIdKey";
static NSString * const kFFUserFirstNameKey	   = @"kFFUserFirstNameKey";
static NSString * const kFFUserLastNameKey	   = @"kFFUserLastNameKey";
static NSString * const kFFUserAddressKey	   = @"kFFUserAddressKey";
static NSString * const kFFUserPhotoPreviewKey = @"kFFUserPhotoPreviewKey";
static NSString * const kFFUserPhotoKey		   = @"kFFUserPhotoKey";

@implementation FFUserData

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)cleanup {
	self.profileId = nil;
	self.firstName = nil;
	self.lastName = nil;
	self.address = nil;
	
	self.photoPreview = nil;
	self.photo = nil;
}

#pragma mark -
#pragma mark NSCoding

- (id)initWithCoder:(NSCoder *)decoder {
    self = [super init];
	
    if (self) {
		self.profileId = [decoder decodeObjectForKey:kFFProfileIdKey];
		self.firstName = [decoder decodeObjectForKey:kFFUserFirstNameKey];
		self.lastName = [decoder decodeObjectForKey:kFFUserLastNameKey];
		self.address = [decoder decodeObjectForKey:kFFUserAddressKey];
		
		self.photoPreview = [decoder decodeObjectForKey:kFFUserPhotoPreviewKey];
		self.photo = [decoder decodeObjectForKey:kFFUserPhotoKey];
	}
	
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
	[coder encodeObject:self.profileId forKey:kFFProfileIdKey];
	[coder encodeObject:self.firstName forKey:kFFUserFirstNameKey];
	[coder encodeObject:self.lastName forKey:kFFUserLastNameKey];
	[coder encodeObject:self.address forKey:kFFUserAddressKey];
	
	[coder encodeObject:self.photoPreview forKey:kFFUserPhotoPreviewKey];
	[coder encodeObject:self.photo forKey:kFFUserPhotoKey];
}

@end
