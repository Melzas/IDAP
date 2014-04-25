//
//  CMUserLocationContext.m
//  Compo
//
//  Created by Anton Rayev on 4/24/14.
//  Copyright (c) 2014 Anton Rayev. All rights reserved.
//

#import "CMUserLocationContext.h"

#import "CMUser.h"

#import "CMUserGeocodingContext.h"

@interface CMUserLocationContext () <CLLocationManagerDelegate, IDPModelObserver>
@property (nonatomic, retain)	CLLocationManager		*locationManager;
@property (nonatomic, retain)	CMUserGeocodingContext	*geocodingContext;

@end

@implementation CMUserLocationContext

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
		[_locationManager stopUpdatingLocation];
	}
	
	IDPNonatomicRetainPropertySynthesize(_locationManager, locationManager);
}

- (void)setGeocodingContext:(CMUserGeocodingContext *)geocodingContext {
	IDPNonatomicRetainPropertySynthesizeWithObserver(_geocodingContext, geocodingContext);
}

#pragma mark -
#pragma mark Public

- (void)cancel {
	self.locationManager = nil;
	self.geocodingContext = nil;
	
	[super cancel];
}

#pragma mark -
#pragma mark Private

- (void)performLoading {
	CLLocationManager *locationManager = [CLLocationManager object];
	locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
	locationManager.distanceFilter = kCLDistanceFilterNone;
	locationManager.delegate = self;
	
	self.locationManager = locationManager;
	[locationManager startUpdatingLocation];
}

#pragma mark -
#pragma mark CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
	self.locationManager = nil;
	
	CLLocation *recentLocation = [locations lastObject];
	CLLocationCoordinate2D coordinate = recentLocation.coordinate;
	
	CMUser *user = self.user;
	user.coordinate = coordinate;
	
	CMUserGeocodingContext *geocodingContext = [CMUserGeocodingContext object];
	geocodingContext.user = user;
	geocodingContext.coordinate = coordinate;
	[geocodingContext load];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
	self.locationManager = nil;
	
	[self failLoading];
}

#pragma mark -
#pragma mark IDPModelObserver

- (void)modelDidLoad:(id)model {
	self.geocodingContext = nil;
	
	[self finishLoading];
}

- (void)modelDidFailToLoad:(id)model {
	self.geocodingContext = nil;
	
	[self failLoading];
}

@end
