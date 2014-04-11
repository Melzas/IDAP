//
//  FFUserData.m
//  FacebookFriends
//
//  Created by Anton Rayev on 3/19/14.
//  Copyright (c) 2014 Anton Rayev. All rights reserved.
//

#import "FFUser.h"

#import "FFImageModel.h"

@interface FFUser ()
@property (nonatomic, retain)	NSSet	*photos;

@end

@implementation FFUser

@dynamic profileID;
@dynamic firstName;
@dynamic lastName;
@dynamic address;
@dynamic photos;

@synthesize photoPreview = _photoPreview;
@synthesize photo = _photo;

#pragma mark -
#pragma mark Private

- (void)awakeFromInsert {
	[super awakeFromInsert];
	
	IDPModelMixin *modelMixin = [IDPModelMixin modelWithTarget:self];
	[self extendWithObject:modelMixin];
}

#pragma mark -
#pragma mark Acessors

- (FFImageModel *)photoPreview {
	if (nil != _photoPreview) {
		return _photoPreview;
	}
	
	NSSet *photos = self.photos;
	for (FFImageModel *photo in photos) {
		if (kFFIcon == photo.type) {
			return photo;
		}
	}
	
	return nil;
}

- (FFImageModel *)photo {
	NSArray *result = [self primitiveValueForKey:NSStringFromSelector(@selector(photo))];
	
	return [result firstObject];
}

@end
