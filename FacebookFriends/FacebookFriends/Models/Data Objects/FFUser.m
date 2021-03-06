//
//  FFUserData.m
//  FacebookFriends
//
//  Created by Anton Rayev on 3/19/14.
//  Copyright (c) 2014 Anton Rayev. All rights reserved.
//

#import "FFUser.h"

#import "FFImage.h"

@interface FFUser ()
@property (nonatomic, retain)	NSSet	*photos;

- (FFImage *)photoForType:(FFImageType)imageType;

@end

@implementation FFUser

@dynamic profileID;
@dynamic firstName;
@dynamic lastName;
@dynamic address;
@dynamic photos;

@dynamic photoPreview;
@dynamic photo;

- (id)				initWithEntity:(NSEntityDescription *)entity
	insertIntoManagedObjectContext:(NSManagedObjectContext *)context
{
	if (self = [super initWithEntity:entity insertIntoManagedObjectContext:context]) {
		IDPModelMixin *modelMixin = [IDPModelMixin modelWithTarget:self];
		[self extendWithObject:modelMixin];
	}
	
	return self;
}

#pragma mark -
#pragma mark Accessors

- (void)setPhotoPreview:(FFImage *)photoPreview {
	photoPreview.type = kFFIcon;
	
	[self addCustomValue:photoPreview inMutableSetForKey:NSStringFromSelector(@selector(photos))];
}

- (FFImage *)photoPreview {
	return [self photoForType:kFFIcon];
}

- (void)setPhoto:(FFImage *)photo {
	photo.type = kFFFull;
	
	[self addCustomValue:photo inMutableSetForKey:NSStringFromSelector(@selector(photos))];
}

- (FFImage *)photo {
	return [self photoForType:kFFFull];
}

#pragma mark -
#pragma mark Private

- (FFImage *)photoForType:(FFImageType)imageType {
	NSSet *photos = self.photos;
	
	for (FFImage *photo in photos) {
		if (imageType == photo.type) {
			return photo;
		}
	}
	
	return nil;
}

- (void)awakeFromInsert {
	[super awakeFromInsert];

	self.photos = [NSSet set];
}

@end
