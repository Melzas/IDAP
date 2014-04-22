//
//  CMMapView.m
//  Compo
//
//  Created by Anton on 22.04.14.
//  Copyright (c) 2014 Anton Rayev. All rights reserved.
//

#import "CMMapView.h"

@implementation CMMapView

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
	self.mapView = nil;
	
	[super dealloc];
}

@end
