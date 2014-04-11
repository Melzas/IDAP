//
//  FFUsersData.h
//  FacebookFriends
//
//  Created by Anton Rayev on 3/20/14.
//  Copyright (c) 2014 Anton Rayev. All rights reserved.
//

#import "IDPModel.h"

@class FFUser;

@interface FFUsers : IDPModel
@property (nonatomic, readonly)	NSArray		*models;

- (void)addUser:(FFUser *)user;
- (void)removeUser:(FFUser *)user;

@end
