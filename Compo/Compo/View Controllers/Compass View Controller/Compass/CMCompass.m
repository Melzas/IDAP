//
//  CMCompass.m
//  Compo
//
//  Created by Anton on 27.04.14.
//  Copyright (c) 2014 Anton Rayev. All rights reserved.
//

#import "CMCompass.h"

#import "CMCompassCircle.h"

#import "CMSwirlGestureRecognizer.h"

static const CGFloat kCMAnimationDuration = 1;

@interface CMCompass ()
@property (nonatomic, retain)	CMCompassCircle	*circle;
@property (nonatomic, retain)	UIView			*shadow;

- (void)setup;
- (void)handleSwirlGesture:(CMSwirlGestureRecognizer *)gestureRecognizer;

@end

@implementation CMCompass

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
	self.circle = nil;
	self.shadow = nil;
	
	[super dealloc];
}

- (id)initWithCoder:(NSCoder *)decoder {
    self = [super initWithCoder:decoder];
    if (self) {
		[self setup];
    }
	
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
		[self setup];
    }
	
    return self;
}

#pragma mark -
#pragma mark Accessors

- (void)setAngle:(CGFloat)angle {
	[self setAngle:angle animated:NO];
}

- (void)setAngle:(CGFloat)angle animated:(BOOL)animated {
	NSTimeInterval animationDuration = animated ? kCMAnimationDuration : 0;
	
	[UIView animateWithDuration:animationDuration animations:^{
		CMCompassCircle *circle = self.circle;
		circle.transform = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(-angle));
		
		IDPNonatomicAssignPropertySynthesize(_angle, angle);
	}];
}

#pragma mark -
#pragma mark Interface Handling

- (void)handleSwirlGesture:(CMSwirlGestureRecognizer *)gestureRecognizer {
	CGFloat angle = RADIANS_TO_DEGREES(gestureRecognizer.rotation);
	UIGestureRecognizerState state = gestureRecognizer.state;
	
	if (UIGestureRecognizerStateEnded == state || UIGestureRecognizerStateCancelled == state) {
		[self setAngle:self.angle - angle animated:YES];
	} else {
		[self setAngle:angle animated:YES];
	}
}

#pragma mark -
#pragma mark Public

- (void)setShadowWithSize:(CGSize)size opacity:(CGFloat)opacity {
	CALayer *layer = self.shadow.layer;
	
	layer.shadowColor = [UIColor blackColor].CGColor;
	layer.shadowOffset = size;
	layer.shadowOpacity = opacity;
	layer.shadowPath = [UIBezierPath bezierPathWithOvalInRect:self.circle.rect].CGPath;
}

#pragma mark -
#pragma mark Private

- (void)setup {
	UIView *shadow = [[[UIView alloc] initWithFrame:self.bounds] autorelease];
	shadow.backgroundColor = [UIColor clearColor];
	[self addSubview:shadow];
	self.shadow = shadow;
	
	CMCompassCircle *circle = [[[CMCompassCircle alloc] initWithFrame:self.bounds] autorelease];
	[self addSubview:circle];
	self.circle = circle;
	
	CMSwirlGestureRecognizer *gestureRecognizer = [CMSwirlGestureRecognizer object];
	gestureRecognizer.center = CGCenter(circle.rect);
	gestureRecognizer.innerRadius = circle.radius / 3;
	gestureRecognizer.outerRadius = circle.radius;
	[gestureRecognizer addTarget:self action:@selector(handleSwirlGesture:)];
	
	[self addGestureRecognizer:gestureRecognizer];
}

@end
