//
//  CMMapAnnotation.h
//  Compo
//
//  Created by Anton on 22.04.14.
//  Copyright (c) 2014 Anton Rayev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CMAnnotation : NSObject <MKAnnotation>
@property (nonatomic, readonly)			CLLocationCoordinate2D	coordinate;
@property (nonatomic, copy, readonly)	NSString				*title;

+ (id)annotationWithDistance:(CGFloat)distance
					 degrees:(CGFloat)degrees
			  fromCoordinate:(CLLocationCoordinate2D)coordinate;

- (id)initWithDistance:(CGFloat)distance
			   degrees:(CGFloat)degrees
		fromCoordinate:(CLLocationCoordinate2D)coordinate;

@end
