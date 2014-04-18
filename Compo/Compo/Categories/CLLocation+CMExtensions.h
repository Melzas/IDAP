//
//  CLLocation+CMExtensions.h
//  Compo
//
//  Created by Anton Rayev on 4/30/14.
//  Copyright (c) 2014 Anton Rayev. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>

#pragma mark -
#pragma mark CLLocationDistance2D

typedef struct {
	CLLocationDistance dx;
	CLLocationDistance dy;
} CLLocationDistance2D;

CLLocationDistance2D CLLocationDistance2DMake(CLLocationDistance dx, CLLocationDistance dy);

CLLocationDistance2D CLLocationDistance2DConvert(CLLocationDistance distance,
												 CLLocationDirection angleInDegrees);

CLLocationCoordinate2D CLCoordinateTranslateToDistance(CLLocationCoordinate2D coordinate,
													   CLLocationDistance2D distance);
