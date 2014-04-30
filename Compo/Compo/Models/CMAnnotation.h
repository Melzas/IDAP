//
//  CMMapAnnotation.h
//  Compo
//
//  Created by Anton on 22.04.14.
//  Copyright (c) 2014 Anton Rayev. All rights reserved.
//

#import "CLLocation+CMExtensions.h"

@interface CMAnnotation : NSObject <MKAnnotation>
@property (nonatomic, readonly)			CLLocationCoordinate2D	coordinate;
@property (nonatomic, copy, readonly)	NSString				*title;

+ (id)annotationWithDistance:(CLLocationDistance)distance
					 degrees:(CLLocationDirection)degrees
			  fromCoordinate:(CLLocationCoordinate2D)coordinate;

- (id)initWithDistance:(CLLocationDistance)distance
			   degrees:(CLLocationDirection)degrees
		fromCoordinate:(CLLocationCoordinate2D)coordinate;

@end
