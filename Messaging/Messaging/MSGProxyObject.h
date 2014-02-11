//
//  MSGProxyObject.h
//  Messaging
//
//  Created by Anton Rayev on 2/7/14.
//  Copyright (c) 2014 Anton Rayev. All rights reserved.
//

#import <Foundation/Foundation.h>

// This class intercepts all messages to the target and outputs their selector on screen
// If the target can answer the message, this class forwards the message to the target, otherwise
// it dismisses the message.
@interface MSGProxyObject : NSObject
@property(nonatomic, readonly)  id <NSObject>    target;

+ (id)proxyWithTarget:(id <NSObject>)target;
- (id)initWithTarget:(id <NSObject>)target;

@end
