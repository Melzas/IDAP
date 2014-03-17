//
//  FFUserDetailsLoadingContext.h
//  FacebookFriends
//
//  Created by Anton Rayev on 3/27/14.
//  Copyright (c) 2014 Anton Rayev. All rights reserved.
//

#import "FFFacebookContext.h"

@class FFUser;

@interface FFFacebookUserContext : FFFacebookContext
@property (nonatomic, retain)	FFUser	*user;

@end
