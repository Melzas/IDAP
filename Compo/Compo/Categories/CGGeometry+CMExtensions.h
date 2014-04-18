//
//  CGGeometry+CMExtensions.h
//  Compo
//
//  Created by Anton Rayev on 4/29/14.
//  Copyright (c) 2014 Anton Rayev. All rights reserved.
//

#pragma mark -
#pragma mark Coordinate Convertion

CGPoint CGOriginPolarToCarthesian(CGPoint origin, CGFloat distance, CGFloat angleInDegrees);

CGPoint CGPolarToCarthesian(CGFloat distance, CGFloat angleInDegrees);

#pragma mark -
#pragma mark Vector Maths

typedef struct {
	CGPoint origin;
	CGPoint direction;
} CGVector2D;

CGVector2D CGVector2DMake(CGPoint startPoint, CGPoint endPoint);

CGVector CGVectorMakeFrom2D(CGVector2D vector2D);

CGFloat CGDotProduct(CGVector2D firstVector2D, CGVector2D secondVector2D);

// This method returns the angle in radians between two 2D vectors
CGFloat CGAngleBetweenVectors(CGVector2D firstVector2D, CGVector2D secondVector2D);

#pragma mark -
#pragma mark Circle Maths

CG_INLINE
CGFloat CGRadius(CGRect circleRect) {
	return circleRect.size.width / 2.f;
}

// This method creates a rect for circle inside given |rect|
// with |offset| from |rect| bounds
CGRect CGCircleInRectWithOffset(CGRect rect, CGFloat offset);

// This method returns a point of circle at given angle in degrees
CGPoint CGPointForAngleInCircle(CGFloat angleInDegrees, CGRect circleRect);
