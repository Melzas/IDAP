//
//  CMMapViewController.m
//  Compo
//
//  Created by Anton on 22.04.14.
//  Copyright (c) 2014 Anton Rayev. All rights reserved.
//

#import "CMMapViewController.h"

#import "MKMapView+CMExtensions.h"

#import "CMAnnotation.h"

#import "CMMapView.h"
#import "CMPinView.h"

static NSString * const kCMLocationError = @"Could not retrieve user's location";

static const double				kCMMaxDegrees			 = 360.f;
static const CLLocationDistance	kCMAnnotationDistances[] = {100.f, 500.f, 1000.f, 2000.f};
static const NSUInteger			kCMAnnotationCount		 = sizeof(kCMAnnotationDistances)
	/ sizeof(CLLocationDistance);

@implementation CMMapViewController

#pragma mark -
#pragma mark Accessors

IDPViewControllerViewOfClassGetterSynthesize(CMMapView, mapView);

#pragma mark -
#pragma mark Public

- (NSArray *)createAnnotationsAroundCoordinate:(CLLocationCoordinate2D)coordinate {
	NSMutableArray *annotations = [NSMutableArray arrayWithCapacity:kCMAnnotationCount];
	
	for (NSUInteger i = 0; i < kCMAnnotationCount; ++i) {
		CLLocationDistance distance = kCMAnnotationDistances[i];
		CLLocationDirection degrees = arc4random_uniform(kCMMaxDegrees);
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
	
	[mapView removeAnnotations:mapView.annotations];
	[mapView addAnnotations:[self createAnnotationsAroundCoordinate:userCoordinate]];
}

- (void)mapView:(MKMapView *)mapView didFailToLocateUserWithError:(NSError *)error {
	[UIAlertView showErrorWithMessage:kCMLocationError];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
	if ([annotation isKindOfClass:[CMAnnotation class]]) {
		return [mapView pinForClass:[CMPinView class] withAnnotation:annotation];
	}
	
	return nil;
}

@end
