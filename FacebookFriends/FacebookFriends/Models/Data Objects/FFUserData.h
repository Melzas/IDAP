//
//  FFUserData.h
//  FacebookFriends
//
//  Created by Anton Rayev on 3/19/14.
//  Copyright (c) 2014 Anton Rayev. All rights reserved.
//

@class FFImageModel;

@interface FFUserData : IDPModel <NSCoding>
@property (nonatomic, copy)		NSString		*firstName;
@property (nonatomic, copy)		NSString		*lastName;
@property (nonatomic, retain)	FFImageModel	*photoPreview;

@end
