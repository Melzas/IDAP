//
//  CMMapAnnotation.m
//  Compo
//
//  Created by Anton on 22.04.14.
//  Copyright (c) 2014 Anton Rayev. All rights reserved.
//

#import "CMAnnotation.h"

static const double kCMDegreesInPI = 180.f;

@interface CMAnnotation ()
@property (nonatomic, assign)	CLLocationCoordinate2D	coordinate;
@property (nonatomic, copy)		NSString				*title;

- (CLLocationDirection)convertToRadiansFromDegrees:(CLLocationDirection)degrees;
- (CLLocationDistance2D)convertFromDistance:(CLLocationDistance)distance
									radians:(CLLocationDirection)radians;

- (CLLocationCoordinate2D)translateCoordinate:(CLLocationCoordinate2D)coordinate
								   toDistance:(CLLocationDistance2D)distance;

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
		CLLocationDirection radians = [self convertToRadiansFromDegrees:degrees];
        CLLocationDistance2D distance2D = [self convertFromDistance:distance radians:radians];
		self.coordinate = [self translateCoordinate:coordinate toDistance:distance2D];
		
		MKDistanceFormatter *formatter = [MKDistanceFormatter object];
		formatter.unitStyle = MKDistanceFormatterUnitStyleAbbreviated;
		
		self.title = [formatter stringFromDistance:distance];
    }
	
    return self;
}

#pragma mark -
#pragma mark Private

- (CLLocationDirection)convertToRadiansFromDegrees:(CLLocationDirection)degrees {
	return degrees / kCMDegreesInPI * M_PI;
}

- (CLLocationDistance2D)convertFromDistance:(CLLocationDistance)distance
									radians:(CLLocationDirection)radians
{
	CLLocationDistance2D distance2D;
	distance2D.x = distance * cos(radians);
	distance2D.y = distance * sin(radians);
	
	return distance2D;
}

- (CLLocationCoordinate2D)translateCoordinate:(CLLocationCoordinate2D)coordinate
								   toDistance:(CLLocationDistance2D)distance
{
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coordinate, distance.x, distance.y);
    MKCoordinateSpan span = region.span;
	
	CLLocationCoordinate2D newCoordinate;
    newCoordinate.latitude = coordinate.latitude + span.latitudeDelta;
    newCoordinate.longitude = coordinate.longitude + span.longitudeDelta;
	
    return newCoordinate;
}

@end
