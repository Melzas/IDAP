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

static const CGSize		kCMShadowSize	 = {10, 10};
static const CGFloat	kCMShadowOpacity = 0.7;

@implementation CMCompassView

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
	self.compass = nil;
	
	[super dealloc];
}

#pragma mark -
#pragma mark View Lifecycle

- (void)awakeFromNib {
	[super awakeFromNib];
	
	[self.compass setShadowWithSize:kCMShadowSize opacity:kCMShadowOpacity];
}

#pragma mark -
#pragma mark Public

- (void)fillWithUser:(CMUser *)user {
	[self.compass setAngle:user.heading animated:YES];
}

@end
