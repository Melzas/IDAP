//
//  CMMapAnnotation.m
//  Compo
//
//  Created by Anton on 22.04.14.
//  Copyright (c) 2014 Anton Rayev. All rights reserved.
//

#import "CMAnnotation.h"

@interface CMAnnotation ()
@property (nonatomic, assign)	CLLocationCoordinate2D	coordinate;
@property (nonatomic, copy)		NSString				*title;

@end

@implementation CMAnnotation

#pragma mark -
#pragma mark Class Methods

+ (id)annotationWithDistance:(CLLocationDistance)distance
					 degrees:(CLLocationDirection)degrees
			  fromCoordinate:(CLLocationCoordinate2D)coordinate
{
	return [[[self alloc] initWithDistance:distance
								   degrees:degrees
							fromCoordinate:coordinate] autorelease];
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
	self.title = nil;
	
	[super dealloc];
}

- (id)initWithDistance:(CLLocationDistance)distance
			   degrees:(CLLocationDirection)degrees
		fromCoordinate:(CLLocationCoordinate2D)coordinate
{
    self = [super init];
    if (self) {
		CLLocationDirection radians = DEGREES_TO_RADIANS(degrees);
		
        CLLocationDistance2D distance2D = CLLocationDistance2DConvert(distance, radians);
		self.coordinate = CLCoordinateTranslateToDistance(coordinate, distance2D);
		
		MKDistanceFormatter *formatter = [MKDistanceFormatter object];
		formatter.unitStyle = MKDistanceFormatterUnitStyleAbbreviated;
		
		self.title = [formatter stringFromDistance:distance];
    }
	
    return self;
}

@end
