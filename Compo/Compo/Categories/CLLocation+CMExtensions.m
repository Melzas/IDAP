//
//  CLLocation+CMExtensions.m
//  Compo
//
//  Created by Anton Rayev on 4/30/14.
//  Copyright (c) 2014 Anton Rayev. All rights reserved.
//

#import "CLLocation+CMExtensions.h"

#import "CGGeometry+CMExtensions.h"

CLLocationDistance2D CLLocationDistance2DMake(CLLocationDistance dx, CLLocationDistance dy) {
	CLLocationDistance2D distance2D;
	distance2D.dx = dx;
	distance2D.dy = dy;
	
	return distance2D;
}

CLLocationDistance2D CLLocationDistance2DConvert(CLLocationDistance distance,
												 CLLocationDirection angleInDegrees)
{
	CGPoint point = CGPolarToCarthesian(distance, angleInDegrees);
	
	return CLLocationDistance2DMake(point.x, point.y);
}

CLLocationCoordinate2D CLCoordinateTranslateToDistance(CLLocationCoordinate2D coordinate,
													   CLLocationDistance2D distance)
{
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coordinate, distance.dx, distance.dy);
    MKCoordinateSpan span = region.span;
	
	CLLocationCoordinate2D newCoordinate;
    newCoordinate.latitude = coordinate.latitude + span.latitudeDelta;
    newCoordinate.longitude = coordinate.longitude + span.longitudeDelta;
	
    return newCoordinate;
}
