//
//  MSGProxyObject.m
//  Messaging
//
//  Created by Anton Rayev on 2/7/14.
//  Copyright (c) 2014 Anton Rayev. All rights reserved.
//

#import "MSGProxyObject.h"

#import "NSObject+MSGExtensions.h"

@interface MSGProxyObject ()
@property (nonatomic, retain, readwrite)    id <NSObject>   target;

- (void)printTarget:(id)target selector:(SEL)selector;
- (void)forwardToNil;

@end

@implementation MSGProxyObject

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc
{
    self.target = nil;
    
    [super dealloc];
}

+ (id)proxyWithTarget:(id <NSObject>)target
{
    MSGProxyObject *object = [self object];
    object.target = object;
    
    return object;
}

- (id)initWithTarget:(id<NSObject>)target
{
    self = [super init];
    if (self) {
        self.target = target;
    }
    
    return self;
}

#pragma mark -
#pragma mark Message Forwarding


- (id)forwardingTargetForSelector:(SEL)sel
{
    NSObject *target = self.target;
    if ([target respondsToSelector:sel]) {
        [self printTarget:nil selector:sel];
        return target;
    }
    
    return [super forwardingTargetForSelector:sel];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel
{
    return [super methodSignatureForSelector:@selector(forwardToNil)];
}

- (void)forwardInvocation:(NSInvocation *)invocation
{
    [invocation invokeWithTarget:nil];
    [self printTarget:nil selector:[invocation selector]];
}

#pragma mark -
#pragma mark Private

- (void)printTarget:(id)target selector:(SEL)selector
{
    NSLog(@"\nMessage with selector = %@ was sent to target = %@\n----------------------------\n\n",
          NSStringFromSelector(selector),
          target);
}

- (void)forwardToNil
{
    
}

@end
