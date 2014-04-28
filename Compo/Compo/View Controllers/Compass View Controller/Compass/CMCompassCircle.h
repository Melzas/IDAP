//
//  CMCompass.h
//  Compo
//
//  Created by Anton Rayev on 4/25/14.
//  Copyright (c) 2014 Anton Rayev. All rights reserved.
//

#import <UIKit/UIKit.h>

static const CGFloat kCMDegreesInCircle  = 360.f;

@interface CMCompassCircle : UIView
@property (nonatomic, assign)	CGFloat	thickness;
@property (nonatomic, assign)	CGRect	rect;

@end
