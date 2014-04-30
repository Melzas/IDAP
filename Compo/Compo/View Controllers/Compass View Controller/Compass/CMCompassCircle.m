//
//  CMCompass.m
//  Compo
//
//  Created by Anton Rayev on 4/25/14.
//  Copyright (c) 2014 Anton Rayev. All rights reserved.
//

#import "CMCompassCircle.h"

#import "CGGeometry+CMExtensions.h"

static const CGFloat kCMDefaultThickness	= 3.0f;
static const CGFloat kCMSmallSerifSize		= 8.0f;
static const CGFloat kCMSmallSerifAngle		= 6.0f;
static const CGFloat kCMLargeSerifSize		= 18.0f;
static const CGFloat kCMLargeSerifAngle		= 30.0f;

static NSString * const kCMCDirections[]	 = {@"N", @"E", @"S", @"W"};
static const CGFloat	kCMDirectionAngles[] = {270.0f, 0.0f, 90.0f, 180.0f};
static const NSUInteger kCMDirectionCount	 =	sizeof(kCMCDirections) / sizeof(NSString *);

static const CGFloat	kCMDirectionLabelOffset = 15.0f;

@interface CMCompassCircle ()

- (void)setupSubviews;

- (void)strokeSerifsWithSize:(CGFloat)serifSize
				 angleOffset:(CGFloat)angleOffset
					 context:(CGContextRef)context;

- (CGRect)circleWithOffset:(CGFloat)offset;

@end

@implementation CMCompassCircle

@dynamic rect;
@dynamic radius;

#pragma mark -
#pragma mark Initializations and Deallocations

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
		self.thickness = kCMDefaultThickness;
		self.backgroundColor = [UIColor clearColor];
		
		[self setupSubviews];
	}
	
    return self;
}

#pragma mark -
#pragma mark Accessors

- (CGRect)rect {
	return [self circleWithOffset:self.thickness];
}

- (CGFloat)radius {
	return CGRadius(self.rect);
}

#pragma mark -
#pragma mark Drawing

- (void)drawRect:(CGRect)rect {
	CGContextRef context = UIGraphicsGetCurrentContext();
	
    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
	CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
	CGContextSetLineWidth(context, self.thickness);
	
	CGRect circleRect = self.rect;
	CGContextFillEllipseInRect(context, circleRect);
	CGContextStrokeEllipseInRect(context, circleRect);
	CGContextStrokeEllipseInRect(context, [self circleWithOffset:self.radius + 1]);
	
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
	
	CGRect circleRect = self.rect;
	CGRect innerCircleRect = CGCircleInRectWithOffset(circleRect, serifSize);
	
	for (NSUInteger i = 0; i < pointCount; i += pointsInSerif) {
		CGFloat angle = i / pointsInSerif * angleOffset;
		
		pointsOfSerifs[i] = CGPointForAngleInCircle(angle, circleRect);
		pointsOfSerifs[i + 1] = CGPointForAngleInCircle(angle, innerCircleRect);
	}
	
	CGContextSetLineWidth(context, self.thickness / 2);
	CGContextStrokeLineSegments(context, pointsOfSerifs, pointCount);
	
	free(pointsOfSerifs);
}

#pragma mark -
#pragma mark Private

- (void)setupSubviews {
	for (NSUInteger i = 0; i < kCMDirectionCount; ++i) {
		UILabel *directionLabel = [UILabel object];
		directionLabel.text = kCMCDirections[i];
		[directionLabel sizeToFit];
		
		CGFloat rotationAngle = DEGREES_TO_RADIANS(kCMDirectionAngles[(i + 1) % kCMDirectionCount]);
		directionLabel.transform = CGAffineTransformMakeRotation(rotationAngle);
		
		CGRect innerCircle = [self circleWithOffset:kCMLargeSerifSize + kCMDirectionLabelOffset];
		directionLabel.center = CGPointForAngleInCircle(kCMDirectionAngles[i], innerCircle);
		[self addSubview:directionLabel];
	}
}

- (CGRect)circleWithOffset:(CGFloat)offset {
	return CGCircleInRectWithOffset(self.bounds, offset);
}

@end
