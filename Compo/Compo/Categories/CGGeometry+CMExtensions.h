//
//  CGGeometry+CMExtensions.h
//  Compo
//
//  Created by Anton Rayev on 4/29/14.
//  Copyright (c) 2014 Anton Rayev. All rights reserved.
//

typedef struct {
	CGPoint start;
	CGPoint end;
} CGVector2D;

CG_INLINE
CGVector2D CGVector2DMake(CGPoint startPoint, CGPoint endPoint) {
	CGVector2D vector2D;
	vector2D.start = startPoint;
	vector2D.end = endPoint;
	
	return vector2D;
}

CG_INLINE
CGVector CGVectorMakeFrom2D(CGVector2D vector2D) {
	CGFloat dx = vector2D.end.x - vector2D.start.x;
	CGFloat dy = vector2D.end.y - vector2D.start.y;
	
	return CGVectorMake(dx, dy);
}

CG_INLINE
CGFloat CGDotProduct(CGVector2D firstVector2D, CGVector2D secondVector2D) {
	CGVector firstVector = CGVectorMakeFrom2D(firstVector2D);
	CGVector secondVector = CGVectorMakeFrom2D(secondVector2D);
	
	return firstVector.dx * secondVector.dx + firstVector.dy * secondVector.dy;
}

// returns angle in radians
CG_EXTERN
CGFloat CGAngleBetweenVectors(CGVector2D firstVector2D, CGVector2D secondVector2D);
