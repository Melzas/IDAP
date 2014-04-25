//
//  CMCompass.m
//  Compo
//
//  Created by Anton Rayev on 4/25/14.
//  Copyright (c) 2014 Anton Rayev. All rights reserved.
//

#import "CMCompass.h"

static const CGFloat kCMDefaultThickness = 3;

@interface CMCompass ()
@property (nonatomic, assign)	CGRect	circleBounds;
@property (nonatomic, assign)	CGFloat	halfThickness;

@end

@implementation CMCompass

@dynamic circleBounds;

#pragma mark -
#pragma mark View Lifecycle

- (void)awakeFromNib {
	[super awakeFromNib];
	
	self.thickness = kCMDefaultThickness;
}

#pragma mark -
#pragma mark Accessors

- (CGRect)circleBounds {
	CGRect viewBounds = self.bounds;
	CGPoint viewOrigin = viewBounds.origin;
	CGSize viewSize = viewBounds.size;
	
	CGFloat thickness = self.thickness;
	CGFloat halfThickness = self.halfThickness;
	
	CGPoint origin = CGPointMake(viewOrigin.x + halfThickness, viewOrigin.y + halfThickness);
	CGSize size = CGSizeMake(viewSize.width - thickness, viewSize.height - thickness);
	
	return (CGRect){origin, size};
}

- (CGFloat)halfThickness {
	return self.thickness / 2;
}

#pragma mark -
#pragma mark Drawing

- (void)drawRect:(CGRect)rect {
	CGContextRef context = UIGraphicsGetCurrentContext();
	
    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
	CGContextSetLineWidth(context, self.thickness);
	
	CGRect circleBounds = self.circleBounds;
	CGContextStrokeEllipseInRect(context, circleBounds);
}

@end
