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
#import "CMUser.h"

#import "CMMapView.h"
#import "CMPinView.h"

static NSString * const kCMLocationError = @"Failed to retrieve user's location";

@implementation CMMapViewController

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
	self.user = nil;
	
	[super dealloc];
}

#pragma mark -
#pragma mark View Lifecycle

- (void)viewWillAppear:(BOOL)animated {
	[super viewDidDisappear:animated];
	
	self.mapView.map.showsUserLocation = YES;
}

- (void)viewDidDisappear:(BOOL)animated {
	self.mapView.map.showsUserLocation = NO;
	
	[super viewDidDisappear:animated];
}

#pragma mark -
#pragma mark Accessors

IDPViewControllerViewOfClassGetterSynthesize(CMMapView, mapView);

#pragma mark -
#pragma mark MKMapViewDelegate

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
	CMUser *user = self.user;
	
	user.coordinate = userLocation.coordinate;
	[mapView setCenterCoordinate:user.coordinate animated:YES];
	
	[mapView removeAnnotations:user.annotations];
	[user createAnnotations];
	[mapView addAnnotations:user.annotations];
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
