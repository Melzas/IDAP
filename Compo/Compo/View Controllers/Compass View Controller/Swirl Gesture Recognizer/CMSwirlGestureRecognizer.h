//
//  CMSwirlGestureRecognizer.h
//  Compo
//
//  Created by Anton Rayev on 4/29/14.
//  Copyright (c) 2014 Anton Rayev. All rights reserved.
//

@interface CMSwirlGestureRecognizer : UIGestureRecognizer
@property (nonatomic, assign)	CGFloat	rotation;
@property (nonatomic, assign)	CGPoint	center;
@property (nonatomic, assign)	CGFloat	innerRadius;
@property (nonatomic, assign)	CGFloat	outerRadius;

@end
