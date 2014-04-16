//
//  FFImage.m
//  FacebookFriends
//
//  Created by Anton Rayev on 4/16/14.
//  Copyright (c) 2014 Anton Rayev. All rights reserved.
//

#import "FFImage.h"
#import "FFImageModel.h"

@interface FFImage ()
@property (nonatomic, retain)	FFImageModel	*model;

@end

@implementation FFImage

@dynamic path;
@dynamic type;

@synthesize model = _model;

#pragma mark -
#pragma mark Class Methods

+ (id)managedObjectWithPath:(NSString *)path {
	FFImage *image = [FFImage managedObject];
	image.path = path;
	image.model = [FFImageModel modelWithPath:path];
	
	return image;
}

#pragma mark -
#pragma mark Private

- (void)awakeFromFetch {
	[super awakeFromFetch];
	
	self.model = [FFImageModel modelWithPath:self.path];
}

- (void)didSave {
	[self.model save];
	
	[super didSave];
}

- (void)didTurnIntoFault {
	self.model = nil;
	
	[super didTurnIntoFault];
}



@end
