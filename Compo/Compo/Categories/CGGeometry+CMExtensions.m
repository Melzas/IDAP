//
//  CGGeometry+CMExtensions.m
//  Compo
//
//  Created by Anton Rayev on 4/29/14.
//  Copyright (c) 2014 Anton Rayev. All rights reserved.
//

#import "CGGeometry+CMExtensions.h"

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
