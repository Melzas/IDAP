//
//  CMLocationView.m
//  Compo
//
//  Created by Anton Rayev on 4/25/14.
//  Copyright (c) 2014 Anton Rayev. All rights reserved.
//

#import "CMLocationView.h"

#import "CMUser.h"

@implementation CMLocationView

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
	self.coordinateLabel = nil;
	self.countryLabel = nil;
	self.stateLabel = nil;
	self.cityLabel = nil;
	self.streetLabel = nil;
	self.postalCodeLabel = nil;
	
	[super dealloc];
}

- (void)fillWithUser:(CMUser *)user {
	CLLocationCoordinate2D coordinate = user.coordinate;
	NSString *coordinateText = [NSString stringWithFormat:@"%f, %f",
														  coordinate.latitude,
														  coordinate.longitude];
	self.coordinateLabel.text = coordinateText;
	
	self.countryLabel.text = user.country;
	self.stateLabel.text = user.region;
	self.cityLabel.text = user.city;
	self.streetLabel.text = user.street;
	self.postalCodeLabel.text = user.postalCode;
}

@end
