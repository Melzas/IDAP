//
//  FFUsersData.h
//  FacebookFriends
//
//  Created by Anton Rayev on 3/20/14.
//  Copyright (c) 2014 Anton Rayev. All rights reserved.
//

#import "IDPModel.h"

@class FFUserData;

@interface FFUsersData : IDPModel
@property (nonatomic, readonly)	NSArray		*users;
@property (nonatomic, readonly)	NSString	*savePath;

- (void)addUser:(FFUserData *)user;
- (void)removeUser:(FFUserData *)user;

- (void)moveUserFromIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex;

- (void)save;
- (void)loadFromFile;

@end
