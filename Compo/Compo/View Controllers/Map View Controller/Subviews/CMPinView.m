//
//  CMPinView.m
//  Compo
//
//  Created by Anton Rayev on 4/23/14.
//  Copyright (c) 2014 Anton Rayev. All rights reserved.
//

#import "CMPinView.h"

@implementation CMPinView

#pragma mark -
#pragma mark Initializations and Deallocations

- (id)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self) {
		self.animatesDrop = YES;
		self.canShowCallout = YES;
    }
	
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSString *)reuseIdentifier {
	return NSStringFromClass([self class]);
}

@end
