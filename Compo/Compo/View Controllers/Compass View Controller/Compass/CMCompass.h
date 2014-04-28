//
//  CMCompass.h
//  Compo
//
//  Created by Anton on 27.04.14.
//  Copyright (c) 2014 Anton Rayev. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CMCompassCircle;

@interface CMCompass : UIView
@property (nonatomic, readonly)	CMCompassCircle	*circle;
@property (nonatomic, readonly)	UIView			*shadow;
@property (nonatomic, assign)	CGFloat			angle;

- (void)setShadowWithSize:(CGSize)size opacity:(CGFloat)opacity;
- (void)setAngle:(CGFloat)angle animated:(BOOL)animated;

@end
