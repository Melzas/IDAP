//
//  FFUserData.h
//  FacebookFriends
//
//  Created by Anton Rayev on 3/19/14.
//  Copyright (c) 2014 Anton Rayev. All rights reserved.
//

#import <CoreData/NSManagedObject.h>

@class FFImageModel;

@interface FFUser : NSManagedObject <IDPModel>
@property (nonatomic, copy)		NSString	*profileID;
@property (nonatomic, copy)		NSString	*firstName;
@property (nonatomic, copy)		NSString	*lastName;
@property (nonatomic, copy)		NSString	*address;

@property (nonatomic, retain)	FFImageModel	*photoPreview;
@property (nonatomic, retain)	FFImageModel	*photo;

- (NSComparisonResult)compare:(FFUser *)user;

@end
