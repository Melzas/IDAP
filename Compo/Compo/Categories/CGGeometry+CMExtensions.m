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

CGFloat CGAngleBetweenVectors(CGVector2D firstVector2D, CGVector2D secondVector2D) {
	CGFloat dotProduct = CGDotProduct(firstVector2D, secondVector2D);
	
	CGFloat firstVectorSize = CGDistance(firstVector2D.start, firstVector2D.end);
	CGFloat secondVectorSize = CGDistance(secondVector2D.start, secondVector2D.end);
	CGFloat sizeProduct = firstVectorSize * secondVectorSize;
	
	if (0 == sizeProduct) {
		return 0;
	}
	
	return acos(dotProduct / sizeProduct);
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
	
	CGPoint circleCenter = CGRectGetCenter(circleRect);
	CGFloat circleRadius = CGRadius(circleRect);
	
	CGPoint point;
	point.x = circleCenter.x + circleRadius * cos(angleInRadians);
	point.y = circleCenter.y + circleRadius * sin(angleInRadians);
	
	return point;
}