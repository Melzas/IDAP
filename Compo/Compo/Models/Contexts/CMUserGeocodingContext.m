//
//  CMGeocodingUserContext.m
//  Compo
//
//  Created by Anton Rayev on 4/24/14.
//  Copyright (c) 2014 Anton Rayev. All rights reserved.
//

#import "CMUserGeocodingContext.h"

#import "CMUser.h"

@interface CMUserGeocodingContext ()
@property (nonatomic, retain)	CLGeocoder	*geocoder;

- (void)geocodeDidFinishedWithPlacemark:(CLPlacemark *)placemark error:(NSError *)error;

@end

@implementation CMUserGeocodingContext

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
	self.user = nil;
	[self cancel];
	
	[super dealloc];
}

#pragma mark -
#pragma mark Accessors

- (void)setGeocoder:(CLGeocoder *)geocoder {
	if (geocoder != _geocoder) {
		[_geocoder cancelGeocode];
	}
	
	IDPNonatomicRetainPropertySynthesize(_geocoder, geocoder);
}

- (void)cancel {
	self.geocoder = nil;
	
	[super cancel];
}

#pragma mark -
#pragma mark Private

- (void)performLoading {
	CLLocationCoordinate2D coordinate = self.coordinate;
	CLLocation *location = [[[CLLocation alloc] initWithLatitude:coordinate.latitude
													   longitude:coordinate.longitude] autorelease];
	
	CLGeocodeCompletionHandler completionHandler = ^(NSArray *placemarks, NSError *error) {
		[self geocodeDidFinishedWithPlacemark:[placemarks lastObject] error:error];
	};
	
	CLGeocoder *geocoder = [CLGeocoder object];
	[geocoder reverseGeocodeLocation:location completionHandler:completionHandler];
	self.geocoder = geocoder;
}

- (void)geocodeDidFinishedWithPlacemark:(CLPlacemark *)placemark error:(NSError *)error {
	self.geocoder = nil;
	
	if (nil != error) {
		[self failLoading];
		return;
	}
	
	CMUser *user = self.user;
	user.country = placemark.country;
	user.region = placemark.administrativeArea;
	user.city = placemark.locality;
	user.street = placemark.thoroughfare;
	user.postalCode = placemark.postalCode;
	
	[self finishLoading];
}

@end
