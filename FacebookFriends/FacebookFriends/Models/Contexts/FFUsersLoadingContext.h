//
//  FFUserLoadingContext.h
//  FacebookFriends
//
//  Created by Anton Rayev on 3/19/14.
//  Copyright (c) 2014 Anton Rayev. All rights reserved.
//

#import "IDPModel.h"

@class FFUsersData;

@interface FFUsersLoadingContext : NSObject

- (void)loadUsers:(FFUsersData *)users;

@end
