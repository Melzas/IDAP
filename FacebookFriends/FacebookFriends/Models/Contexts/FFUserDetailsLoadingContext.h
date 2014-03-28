//
//  FFUserDetailsLoadingContext.h
//  FacebookFriends
//
//  Created by Anton Rayev on 3/27/14.
//  Copyright (c) 2014 Anton Rayev. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FFUserData;

@interface FFUserDetailsLoadingContext : IDPModel
@property (nonatomic, retain)	FFUserData	*userData;

- (void)cancel;

@end
