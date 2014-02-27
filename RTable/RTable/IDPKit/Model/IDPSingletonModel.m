//
//  IDPSingletonModel.m
//  MovieScript
//
//  Created by Artem Chabanniy on 10/09/2013.
//  Copyright (c) 2013 IDAP Group. All rights reserved.
//

#import "IDPSingletonModel.h"
#import "NSObject+IDPExtensions.h"

@implementation IDPSingletonModel

#pragma mark -
#pragma mark Class methods

+ (id)__sharedObject {
    NSAssert(NO, @"override me");
    return NULL;
}

+ (id)sharedObject {
    NSAssert(NO, @"override me");
    return NULL;
}


#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    
    [super dealloc];
}

+ (id)allocWithZone:(NSZone *)zone {
    __block id result = [self __sharedObject];
    
	if (![self __sharedObject]) {
		result = [super allocWithZone:zone];
	}
    
    return result;
}

- (id)copyWithZone:(NSZone *)zone {
    return self;
}

- (id)retain {
    return self;
}

- (NSUInteger)retainCount {
    return NSUIntegerMax;  //denotes an object that cannot be released
}

- (oneway void)release {
    //do nothing
}

- (id)autorelease {
    return self;
}

@end
