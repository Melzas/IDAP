//
//  CMMapViewController.m
//  Compo
//
//  Created by Anton on 22.04.14.
//  Copyright (c) 2014 Anton Rayev. All rights reserved.
//

#import "CMMapViewController.h"

#import "CMAnnotation.h"

#import "CMMapView.h"

static NSString * const kCMLocationError = @"Could not retrieve user's location";

static const CGFloat	kCMAnnotationDistances[] = {100, 200, 1000, 2000};
static const NSUInteger	kCMAnnotationCount		 = sizeof(kCMAnnotationDistances) / sizeof(CGFloat);

@interface CMMapViewController () <MKMapViewDelegate>

@end

@implementation CMMapViewController

#pragma mark -
#pragma mark Accessors

IDPViewControllerViewOfClassGetterSynthesize(CMMapView, mapView);

#pragma mark -
#pragma mark Public

- (NSArray *)createAnnotationsAroundCoordinate:(CLLocationCoordinate2D)coordinate {
	NSMutableArray *annotations = [NSMutableArray arrayWithCapacity:kCMAnnotationCount];
	
	for (NSUInteger i = 0; i < kCMAnnotationCount; ++i) {
		CGFloat distance = kCMAnnotationDistances[i];
		CGFloat degrees = arc4random_uniform(2 * M_PI);
		CMAnnotation *annotation = [CMAnnotation annotationWithDistance:distance
																degrees:degrees
														 fromCoordinate:coordinate];
		[annotations addObject:annotation];
	}
		
	return annotations;
}

#pragma mark -
#pragma mark MKMapViewDelegate

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
	CLLocationCoordinate2D userCoordinate = userLocation.coordinate;
	[mapView setCenterCoordinate:userCoordinate animated:YES];
	
//	[mapView addAnnotations:[self createAnnotationsAroundCoordinate:userCoordinate]];
	[mapView showAnnotations:[self createAnnotationsAroundCoordinate:userCoordinate] animated:YES];
}

- (void)mapView:(MKMapView *)mapView didFailToLocateUserWithError:(NSError *)error {
	[UIAlertView showErrorWithMessage:kCMLocationError];
}

@end
