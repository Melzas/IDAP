//
//  FFUserLoadingContext.h
//  FacebookFriends
//
//  Created by Anton Rayev on 3/19/14.
//  Copyright (c) 2014 Anton Rayev. All rights reserved.
//

#import "FFFacebookContext.h"

@class FFUsers;

@interface FFFacebookUsersContext : FFFacebookContext
@property (nonatomic, retain)	FFUsers	*users;

@end
