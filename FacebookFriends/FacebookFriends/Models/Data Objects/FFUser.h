//
//  FFUserData.h
//  FacebookFriends
//
//  Created by Anton Rayev on 3/19/14.
//  Copyright (c) 2014 Anton Rayev. All rights reserved.
//

@class FFImageModel;

@interface FFUser : IDPModel <NSCoding>
@property (nonatomic, copy)		NSString		*profileId;
@property (nonatomic, copy)		NSString		*firstName;
@property (nonatomic, copy)		NSString		*lastName;
@property (nonatomic, copy)		NSString		*address;
@property (nonatomic, retain)	FFImageModel	*photoPreview;
@property (nonatomic, retain)	FFImageModel	*photo;

@end
