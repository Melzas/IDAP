//
//  CMGeocodingUserContext.h
//  Compo
//
//  Created by Anton Rayev on 4/24/14.
//  Copyright (c) 2014 Anton Rayev. All rights reserved.
//

@class CMUser;

@interface CMUserGeocodingContext : IDPModel
@property (nonatomic, retain)	CMUser					*user;
@property (nonatomic, assign)	CLLocationCoordinate2D	coordinate;

@end
