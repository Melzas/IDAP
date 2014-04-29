//
//  CMUserHeadingContext.m
//  Compo
//
//  Created by Anton Rayev on 4/29/14.
//  Copyright (c) 2014 Anton Rayev. All rights reserved.
//

#import "CMUserHeadingContext.h"

#import "CMUser.h"

@interface CMUserHeadingContext () <CLLocationManagerDelegate>
@property (nonatomic, retain)	CLLocationManager		*locationManager;

@end

@implementation CMUserHeadingContext

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
	self.user = nil;
	[self cancel];
	
	[super dealloc];
}

#pragma mark -
#pragma mark Accessors

- (void)setLocationManager:(CLLocationManager *)locationManager {
	if (locationManager != _locationManager) {
		[_locationManager stopUpdatingHeading];
	}
	
	IDPNonatomicRetainPropertySynthesize(_locationManager, locationManager);
}

#pragma mark -
#pragma mark Public

- (void)cancel {
	self.locationManager = nil;
	
	[super cancel];
}

#pragma mark -
#pragma mark Private

- (void)performLoading {
	if (![CLLocationManager headingAvailable]) {
		[self failLoading];
		return;
	}
	
	CLLocationManager *locationManager = [CLLocationManager object];
	[locationManager startUpdatingHeading];
	self.locationManager = locationManager;
}

#pragma mark -
#pragma mark CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading {
	self.user.heading = newHeading.magneticHeading;
	
	[self finishLoading];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
	self.locationManager = nil;
	
	[self failLoading];
}

@end
