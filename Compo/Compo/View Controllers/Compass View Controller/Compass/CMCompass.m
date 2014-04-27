//
//  CMCompass.m
//  Compo
//
//  Created by Anton on 27.04.14.
//  Copyright (c) 2014 Anton Rayev. All rights reserved.
//

#import "CMCompass.h"

#import "CMCompassCircle.h"

@interface CMCompass ()
@property (nonatomic, retain)	CMCompassCircle	*circle;
@property (nonatomic, retain)	UIView			*shadow;

- (void)setupSubviews;

@end

@implementation CMCompass

#pragma mark -
#pragma mark Initializations and Deallocations

-(void)dealloc {
	self.circle = nil;
	self.shadow = nil;
	
	[super dealloc];
}

- (id)initWithCoder:(NSCoder *)decoder {
    self = [super initWithCoder:decoder];
    if (self) {
		[self setupSubviews];
    }
	
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
		[self setupSubviews];
    }
	
    return self;
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

- (void)setupSubviews {
	UIView *shadow = [[[UIView alloc] initWithFrame:self.bounds] autorelease];
	shadow.backgroundColor = [UIColor clearColor];
	[self addSubview:shadow];
	self.shadow = shadow;
	
	self.circle = [[[CMCompassCircle alloc] initWithFrame:self.bounds] autorelease];
	[self addSubview:self.circle];
}

@end
