//
//  CMUser.h
//  Compo
//
//  Created by Anton Rayev on 4/24/14.
//  Copyright (c) 2014 Anton Rayev. All rights reserved.
//

@interface CMUser : NSObject
@property (nonatomic, assign)	CLLocationCoordinate2D	coordinate;
@property (nonatomic, copy)		NSString				*country;
@property (nonatomic, copy)		NSString				*region;
@property (nonatomic, copy)		NSString				*city;
@property (nonatomic, copy)		NSString				*street;
@property (nonatomic, copy)		NSString				*postalCode;

@property (nonatomic, readonly)	NSArray					*annotations;
@property (nonatomic, assign)	CLLocationDirection		heading;

- (void)createAnnotations;

@end
