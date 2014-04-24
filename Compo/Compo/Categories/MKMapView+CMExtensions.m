//
//  MKAnnotationView+CMExtensions.m
//  Compo
//
//  Created by Anton Rayev on 4/24/14.
//  Copyright (c) 2014 Anton Rayev. All rights reserved.
//

#import "MKMapView+CMExtensions.h"

@implementation MKMapView (CMExtensions)

- (id)pinForClass:(Class)class withAnnotation:(id<MKAnnotation>)annotation {
	NSString *reuseIdentifier = NSStringFromClass(class);
	id pin = [self dequeueReusableAnnotationViewWithIdentifier:reuseIdentifier];
	
	if (nil == pin) {
		pin = [[[class alloc] initWithAnnotation:annotation
								 reuseIdentifier:reuseIdentifier] autorelease];
	}
	
	return pin;
}

@end
