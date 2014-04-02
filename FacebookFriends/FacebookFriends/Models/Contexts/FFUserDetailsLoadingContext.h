//
//  FFUserDetailsLoadingContext.h
//  FacebookFriends
//
//  Created by Anton Rayev on 3/27/14.
//  Copyright (c) 2014 Anton Rayev. All rights reserved.
//

#import "FFLoadingContext.h"

@class FFUserData;

@interface FFUserDetailsLoadingContext : FFLoadingContext
@property (nonatomic, retain)	FFUserData	*userData;

@end
