//
//  CGGeometry+CMExtensions.m
//  Compo
//
//  Created by Anton Rayev on 4/29/14.
//  Copyright (c) 2014 Anton Rayev. All rights reserved.
//

#import "CGGeometry+CMExtensions.h"

#pragma mark -
#pragma mark Coordinate Convertion

CGPoint CGOriginPolarToCarthesian(CGPoint origin, CGFloat distance, CGFloat angleInDegrees) {
	CGFloat angleInRadians = DEGREES_TO_RADIANS(angleInDegrees);
	
	CGPoint point;
	point.x = origin.x + distance * cos(angleInRadians);
	point.y = origin.y + distance * sin(angleInRadians);
	
	return point;
}

CGPoint CGPolarToCarthesian(CGFloat distance, CGFloat angleInDegrees) {
	return CGOriginPolarToCarthesian(CGPointMake(0.f, 0.f), distance, angleInDegrees);
}

#pragma mark -
#pragma mark Vector Maths

CGVector2D CGVector2DMake(CGPoint origin, CGPoint direction) {
	CGVector2D vector2D;
	vector2D.origin = origin;
	vector2D.direction = direction;
	
	return vector2D;
}

CGVector CGVectorMakeFrom2D(CGVector2D vector2D) {
	CGFloat dx = vector2D.direction.x - vector2D.origin.x;
	CGFloat dy = vector2D.direction.y - vector2D.origin.y;
	
	return CGVectorMake(dx, dy);
}

CGFloat CGDotProduct(CGVector2D firstVector2D, CGVector2D secondVector2D) {
	CGVector firstVector = CGVectorMakeFrom2D(firstVector2D);
	CGVector secondVector = CGVectorMakeFrom2D(secondVector2D);
	
	return firstVector.dx * secondVector.dx + firstVector.dy * secondVector.dy;
}

CGFloat CGAngleBetweenVectors(CGVector2D firstVector2D, CGVector2D secondVector2D) {
	CGVector firstVector = CGVectorMakeFrom2D(firstVector2D);
	CGVector secondVector = CGVectorMakeFrom2D(secondVector2D);
	
	return atan2(secondVector.dy, secondVector.dx) - atan2(firstVector.dy, firstVector.dx);
}

#pragma mark -
#pragma mark Circle Maths

CGRect CGCircleInRectWithOffset(CGRect rect, CGFloat offset) {
	return CGRectInset(rect, offset, offset);
}

CGPoint CGPointForAngleInCircle(CGFloat angleInDegrees, CGRect circleRect) {
	CGPoint circleCenter = CGCenter(circleRect);
	CGFloat circleRadius = CGRadius(circleRect);
	
	return CGOriginPolarToCarthesian(circleCenter, circleRadius, angleInDegrees);
}