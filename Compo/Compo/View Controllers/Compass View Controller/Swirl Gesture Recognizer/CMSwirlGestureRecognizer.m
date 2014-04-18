//
//  CMSwirlGestureRecognizer.m
//  Compo
//
//  Created by Anton Rayev on 4/29/14.
//  Copyright (c) 2014 Anton Rayev. All rights reserved.
//

#import "CMSwirlGestureRecognizer.h"

#import <UIKit/UIGestureRecognizerSubclass.h>

#import "CGGeometry+CMExtensions.h"

@implementation CMSwirlGestureRecognizer

- (void)reset {
	self.rotation = 0.f;
	
	[super reset];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	[super touchesBegan:touches withEvent:event];
	
	if (1 < [touches count]) {
		self.state = UIGestureRecognizerStateFailed;
		return;
	}
	
	self.state = UIGestureRecognizerStateBegan;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	[super touchesMoved:touches withEvent:event];
	
	if (UIGestureRecognizerStateFailed == self.state) {
		return;
	}
	
	UIView *view = self.view;
	CGPoint currentPoint = [[touches anyObject] locationInView:view];
	CGPoint previousPoint = [[touches anyObject] previousLocationInView:view];
	
	CGPoint center = self.center;
	CGFloat distance = CGDistance(currentPoint, center);
	
	if (!CGFloatInRange(distance, self.innerRadius, self.outerRadius)) {
		self.state = UIGestureRecognizerStateCancelled;
		return;
	}
	
	CGVector2D startVector = CGVector2DMake(center, previousPoint);
	CGVector2D endVector = CGVector2DMake(center, currentPoint);
	self.rotation += CGAngleBetweenVectors(endVector, startVector);
	
	self.state = UIGestureRecognizerStateChanged;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	[super touchesEnded:touches withEvent:event];
	
	if (UIGestureRecognizerStateChanged == self.state) {
		self.state = UIGestureRecognizerStateEnded;
	}
	
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
	[super touchesCancelled:touches withEvent:event];
	
	[self reset];
	self.state = UIGestureRecognizerStateCancelled;
}

@end
