//
//  CMLocationView.m
//  Compo
//
//  Created by Anton Rayev on 4/25/14.
//  Copyright (c) 2014 Anton Rayev. All rights reserved.
//

#import "CMLocationView.h"

#import "CMUser.h"

@interface CMLocationView ()
@property (nonatomic, retain)	IDPLoadingView		*loadingView;

@end

@implementation CMLocationView

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
	self.coordinateLabel = nil;
	self.countryLabel = nil;
	self.regionLabel = nil;
	self.cityLabel = nil;
	self.streetLabel = nil;
	self.postalCodeLabel = nil;
	self.loadingView = nil;
	
	[super dealloc];
}

#pragma mark -
#pragma mark Accessors

- (void)setLoading:(BOOL)loading {
	if (loading) {
		self.loadingView = [IDPLoadingView loadingViewInView:self];
	} else {
		[self.loadingView removeFromSuperview];
	}
	
	IDPNonatomicAssignPropertySynthesize(_loading, loading);
}

#pragma mark -
#pragma mark Public

- (void)fillWithUser:(CMUser *)user {
	CLLocationCoordinate2D coordinate = user.coordinate;
	NSString *coordinateText = [NSString stringWithFormat:@"%f, %f",
														  coordinate.latitude,
														  coordinate.longitude];
	self.coordinateLabel.text = coordinateText;
	
	self.countryLabel.text = user.country;
	self.regionLabel.text = user.region;
	self.cityLabel.text = user.city;
	self.streetLabel.text = user.street;
	self.postalCodeLabel.text = user.postalCode;
	
	[self.loadingView removeFromSuperview];
}

@end
