//
//  CGGeometry+CMExtensions.m
//  Compo
//
//  Created by Anton Rayev on 4/29/14.
//  Copyright (c) 2014 Anton Rayev. All rights reserved.
//

#import "CGGeometry+CMExtensions.h"

#pragma mark -
#pragma mark Vector Maths

CGVector2D CGVector2DMake(CGPoint startPoint, CGPoint endPoint) {
	CGVector2D vector2D;
	vector2D.start = startPoint;
	vector2D.end = endPoint;
	
	return vector2D;
}

CGVector CGVectorMakeFrom2D(CGVector2D vector2D) {
	CGFloat dx = vector2D.end.x - vector2D.start.x;
	CGFloat dy = vector2D.end.y - vector2D.start.y;
	
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
	CGPoint circleOrigin = {rect.origin.x + offset, rect.origin.y + offset};
	CGSize circleSize = {rect.size.width - 2 * offset, rect.size.height - 2 * offset};
	
	return (CGRect){circleOrigin, circleSize};
}

CGPoint CGPointForAngleInCircle(CGFloat angleInDegrees, CGRect circleRect) {
	CGFloat angleInRadians = DEGREES_TO_RADIANS(angleInDegrees);
	
	CGPoint circleCenter = CGCenter(circleRect);
	CGFloat circleRadius = CGRadius(circleRect);
	
	CGPoint point;
	point.x = circleCenter.x + circleRadius * cos(angleInRadians);
	point.y = circleCenter.y + circleRadius * sin(angleInRadians);
	
	return point;
}