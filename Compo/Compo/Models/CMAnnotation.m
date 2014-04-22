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

- (CGPoint)convertFromDistance:(CGFloat)distance degrees:(CGFloat)degrees;
- (CLLocationCoordinate2D)translateCoordinate:(CLLocationCoordinate2D)coordinate
									  toPoint:(CGPoint)point;

@end

@implementation CMAnnotation

#pragma mark -
#pragma mark Class Methods

+ (id)annotationWithDistance:(CGFloat)distance
					 degrees:(CGFloat)degrees
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

- (id)initWithDistance:(CGFloat)distance
			   degrees:(CGFloat)degrees
		fromCoordinate:(CLLocationCoordinate2D)coordinate
{
    self = [super init];
    if (self) {
        CGPoint point = [self convertFromDistance:distance degrees:degrees];
		self.coordinate = [self translateCoordinate:coordinate toPoint:point];
		
		self.title = [NSString stringWithFormat:@"%f m", distance];
    }
	
    return self;
}

#pragma mark -
#pragma mark Private

- (CGPoint)convertFromDistance:(CGFloat)distance degrees:(CGFloat)degrees {
	CGPoint coordinates;
	coordinates.x = distance * cos(degrees);
	coordinates.y = distance * sin(degrees);
	
	return coordinates;
}

- (CLLocationCoordinate2D)translateCoordinate:(CLLocationCoordinate2D)coordinate
									  toPoint:(CGPoint)point
{
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coordinate, point.x, point.y);
    MKCoordinateSpan span = region.span;
	
	CLLocationCoordinate2D newCoordinate;
    newCoordinate.latitude = coordinate.latitude + span.latitudeDelta;
    newCoordinate.longitude = coordinate.longitude + span.longitudeDelta;
	
    return newCoordinate;
}

@end
