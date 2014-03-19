//
//  FFUserData.h
//  FacebookFriends
//
//  Created by Anton Rayev on 3/19/14.
//  Copyright (c) 2014 Anton Rayev. All rights reserved.
//

#import "IDPModel.h"

@class FFImageModel;

@interface FFUserData : IDPModel <NSCoding>
@property (nonatomic, readonly)	NSString		*name;
@property (nonatomic, readonly)	FFImageModel	*photoPreview;

@end
