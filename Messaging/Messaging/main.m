//
//  main.m
//  Messaging
//
//  Created by Anton Rayev on 2/4/14.
//  Copyright (c) 2014 Anton Rayev. All rights reserved.
//

#import <objc/message.h>

#import <Foundation/Foundation.h>

#import "NSObject+MSGExtensions.h"
#import "MSGObject.h"
#import "MSGProxyObject.h"

int main(int argc, const char * argv[])
{
    @autoreleasepool {
        MSGObject *object = [MSGObject object];
        MSGObject *object2 = [MSGObject object];
        NSObject *object3 = [NSObject object];
        NSString *object4 = [NSString object];
        [object sayHello];
        
        MSGProxyObject *proxy = [MSGProxyObject proxyWithTarget:object];
        object = (MSGObject*)proxy;
        [object sayHello];
        [object shutUp];
        [object goForAWalkWithObject:object distance:300];
        
        [object performSelector:@selector(washWondow)];
        
        objc_msgSend(object, @selector(numberOfLadies), 2);
    }
    return 0;
}

