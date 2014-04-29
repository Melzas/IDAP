//
//  CMCompassView.m
//  Compo
//
//  Created by Anton Rayev on 4/25/14.
//  Copyright (c) 2014 Anton Rayev. All rights reserved.
//

#import "CMCompassView.h"

#import "CMUser.h"

#import "CMCompass.h"
#import "CMCompassCircle.h"

#import "CMSwirlGestureRecognizer.h"

static const CGSize		kCMShadowSize	 = {10, 10};
static const CGFloat	kCMShadowOpacity = 0.7;

@implementation CMCompassView

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
	self.compass = nil;
	self.swirlGestureRecognizer = nil;
	
	[super dealloc];
}

#pragma mark -
#pragma mark View Lifecycle

- (void)awakeFromNib {
	[super awakeFromNib];
	
	[self.compass setShadowWithSize:kCMShadowSize opacity:kCMShadowOpacity];
	
	CMCompassCircle *compassCircle = self.compass.circle;
	CMSwirlGestureRecognizer *gestureRecognizer = [CMSwirlGestureRecognizer object];
	gestureRecognizer.center = CGCenter(compassCircle.rect);
	gestureRecognizer.innerRadius = 1.f;
	gestureRecognizer.outerRadius = 220.f;
	
	[self addGestureRecognizer:gestureRecognizer];
	self.swirlGestureRecognizer = gestureRecognizer;
}

#pragma mark -
#pragma mark Public

- (void)fillWithUser:(CMUser *)user {
	[self.compass setAngle:user.heading animated:YES];
}

@end
