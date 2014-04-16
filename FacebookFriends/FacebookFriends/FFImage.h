//
//  FFImage.h
//  FacebookFriends
//
//  Created by Anton Rayev on 4/16/14.
//  Copyright (c) 2014 Anton Rayev. All rights reserved.
//

typedef enum FFImageType : int16_t {
	kFFIcon,
	kFFFull
} FFImageType;

@class FFImageModel;

@interface FFImage : NSManagedObject
@property (nonatomic, copy)		NSString		*path;
@property (nonatomic, assign)	FFImageType		type;
@property (nonatomic, readonly)	FFImageModel	*model;

+ (id)managedObjectWithPath:(NSString *)path;

@end
