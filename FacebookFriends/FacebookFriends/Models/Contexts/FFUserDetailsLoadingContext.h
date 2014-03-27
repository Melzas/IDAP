//
//  FFUserDetailsLoadingContext.h
//  FacebookFriends
//
//  Created by Anton Rayev on 3/27/14.
//  Copyright (c) 2014 Anton Rayev. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FFUserData;

@interface FFUserDetailsLoadingContext : NSObject
@property (nonatomic, retain)	FFUserData	*userData;

@property (nonatomic, assign, getter = isNetworkReachable)	BOOL	networkReachable;

- (void)load;
- (void)cancel;

@end
