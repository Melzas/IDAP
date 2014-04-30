//
//  CMUser.m
//  Compo
//
//  Created by Anton Rayev on 4/24/14.
//  Copyright (c) 2014 Anton Rayev. All rights reserved.
//

#import "CMUser.h"

#import "CMAnnotation.h"

static const double				kCMMaxDegrees			 = 360.0f;
static const CLLocationDistance	kCMAnnotationDistances[] = {100.0f, 500.0f, 1000.0f, 2000.0f};
static const NSUInteger			kCMAnnotationCount		 = sizeof(kCMAnnotationDistances)
	/ sizeof(CLLocationDistance);

@interface CMUser ()
@property (nonatomic, retain)	NSMutableArray	*mutableAnnotations;

@end

@implementation CMUser

@dynamic annotations;

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
	self.country = nil;
	self.region = nil;
	self.city = nil;
	self.street = nil;
	self.postalCode = nil;
	
	self.mutableAnnotations = nil;
	
	[super dealloc];
}

- (id)init {
    self = [super init];
    if (self) {
        self.mutableAnnotations = [NSMutableArray arrayWithCapacity:kCMAnnotationCount];
    }
	
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSArray *)annotations {
	return [[self.mutableAnnotations retain] autorelease];
}

#pragma mark -
#pragma mark Public

- (void)createAnnotations {
	NSMutableArray *annotations = self.mutableAnnotations;
	[annotations removeAllObjects];
	
	for (NSUInteger i = 0; i < kCMAnnotationCount; ++i) {
		CLLocationDistance distance = kCMAnnotationDistances[i];
		CLLocationDirection degrees = arc4random_uniform(kCMMaxDegrees);
		
		CMAnnotation *annotation = [CMAnnotation annotationWithDistance:distance
																  angle:degrees
														 fromCoordinate:self.coordinate];
		[annotations addObject:annotation];
	}
}

@end
