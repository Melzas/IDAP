//
//  IDPNetworkReachability+FacebookReachability.m
//  FacebookFriends
//
//  Created by Anton Rayev on 4/18/14.
//  Copyright (c) 2014 Anton Rayev. All rights reserved.
//

#import "IDPNetworkReachability+FacebookReachability.h"

static NSString * const kFFFacebookHost = @"facebook.com";

@implementation IDPNetworkReachability (FacebookReachability)

+ (id)facebookReachabilty {
	return [self reachabilityWithHostName:kFFFacebookHost];
}

@end
