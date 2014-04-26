//
//  CMCompass.m
//  Compo
//
//  Created by Anton Rayev on 4/25/14.
//  Copyright (c) 2014 Anton Rayev. All rights reserved.
//

#import "CMCompass.h"

static const CGFloat kCMDefaultThickness = 3.f;
static const CGFloat kCMDegreesInCircle  = 360.f;

static const CGFloat kCMSmallSerifSize  = 5.f;
static const CGFloat kCMSmallSerifAngle = 6.f;
static const CGFloat kCMLargeSerifSize  = 15.f;
static const CGFloat kCMLargeSerifAngle = 30.f;

@interface CMCompass ()
@property (nonatomic, assign)	CGRect	circleRect;
@property (nonatomic, assign)	CGFloat	halfThickness;

- (void)strokeSerifsWithSize:(CGFloat)serifSize
				 angleOffset:(CGFloat)angleOffset
					 context:(CGContextRef)context;

- (CGPoint)pointForAngle:(CGFloat)angle inCircle:(CGRect)circleRect;
- (CGRect)innerCircleForSerifsWithSize:(CGFloat)serifSize;

@end

@implementation CMCompass

@dynamic circleRect;
@dynamic halfThickness;

#pragma mark -
#pragma mark View Lifecycle

- (void)awakeFromNib {
	[super awakeFromNib];
	
	self.thickness = kCMDefaultThickness;
}

#pragma mark -
#pragma mark Accessors

- (CGRect)circleRect {
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
	
	CGRect circleRect = self.circleRect;
	CGContextStrokeEllipseInRect(context, circleRect);
	
	[self strokeSerifsWithSize:kCMSmallSerifSize angleOffset:kCMSmallSerifAngle context:context];
	[self strokeSerifsWithSize:kCMLargeSerifSize angleOffset:kCMLargeSerifAngle context:context];
}

- (void)strokeSerifsWithSize:(CGFloat)serifSize
				 angleOffset:(CGFloat)angleOffset
					 context:(CGContextRef)context
{
	static const NSUInteger pointsInSerif = 2;
	NSUInteger pointCount = kCMDegreesInCircle / angleOffset * pointsInSerif;
	CGPoint *pointsOfSerifs = malloc(pointCount * sizeof(CGPoint));
	
	CGRect circleRect = self.circleRect;
	CGRect innerCircleRect = [self innerCircleForSerifsWithSize:serifSize];
	
	for (NSUInteger i = 0; i < pointCount; i += pointsInSerif) {
		CGFloat angle = DEGREES_TO_RADIANS(i / pointsInSerif * angleOffset);
		
		pointsOfSerifs[i] = [self pointForAngle:angle inCircle:circleRect];
		pointsOfSerifs[i + 1] = [self pointForAngle:angle inCircle:innerCircleRect];
	}
	
	CGContextSetLineWidth(context, self.halfThickness);
	CGContextStrokeLineSegments(context, pointsOfSerifs, pointCount);
	
	free(pointsOfSerifs);
}

#pragma mark -
#pragma mark Private

- (CGPoint)pointForAngle:(CGFloat)angle inCircle:(CGRect)circleRect {
	CGPoint circleCenter = CGRectGetCenter(circleRect);
	CGFloat circleRadius = CGMidX(circleRect) - CGMinX(circleRect);
	
	CGPoint point;
	point.x = circleCenter.x + circleRadius * cos(angle);
	point.y = circleCenter.y + circleRadius * sin(angle);
	
	return point;
}

- (CGRect)innerCircleForSerifsWithSize:(CGFloat)serifSize {
	CGRect circleRect = self.circleRect;
	
	CGPoint innerCircleOrigin = {circleRect.origin.x + serifSize,
								 circleRect.origin.y + serifSize};
	
	CGSize innerCircleSize = {circleRect.size.width - 2 * serifSize,
							  circleRect.size.height - 2 * serifSize};
	
	return (CGRect){innerCircleOrigin, innerCircleSize};
}

@end
