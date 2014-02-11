//
//  NSObject+MSGExtensions.m
//  Messaging
//
//  Created by Anton Rayev on 2/7/14.
//  Copyright (c) 2014 Anton Rayev. All rights reserved.
//

#import "NSObject+MSGExtensions.h"

@implementation NSObject (MSGExtensions)

+ (id)object
{
    return [[[self alloc] init] autorelease];
}

@end
