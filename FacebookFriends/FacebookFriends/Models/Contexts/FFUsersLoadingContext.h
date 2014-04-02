//
//  FFUserLoadingContext.h
//  FacebookFriends
//
//  Created by Anton Rayev on 3/19/14.
//  Copyright (c) 2014 Anton Rayev. All rights reserved.
//

#import "FFLoadingContext.h"

@class FFUsersData;

@interface FFUsersLoadingContext : FFLoadingContext
@property (nonatomic, retain)	FFUsersData	*usersData;

@end
