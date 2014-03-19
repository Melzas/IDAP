//
//  FFUserData.m
//  FacebookFriends
//
//  Created by Anton Rayev on 3/19/14.
//  Copyright (c) 2014 Anton Rayev. All rights reserved.
//

#import "FFUserData.h"

static NSString * const kFFUserNameKey	= @"kFFUserNameKey";
static NSString * const kFFUserPhotoKey = @"kFFUserPhotoKey";

@interface FFUserData ()
@property (nonatomic, copy)		NSString		*name;
@property (nonatomic, retain)	FFImageModel	*photoPreview;

@end

@implementation FFUserData

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)cleanup {
	self.name = nil;
	self.photoPreview = nil;
}

#pragma mark -
#pragma mark NSCoding

- (id)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if (self) {
		self.name = [decoder decodeObjectForKey:kFFUserNameKey];
		self.photoPreview = [decoder decodeObjectForKey:kFFUserPhotoKey];
    }
	
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
	[coder encodeObject:self.name forKey:kFFUserNameKey];
	[coder encodeObject:self.photoPreview forKey:kFFUserPhotoKey];
}

@end
