//
//  CMMapViewController.h
//  Compo
//
//  Created by Anton on 22.04.14.
//  Copyright (c) 2014 Anton Rayev. All rights reserved.
//

@class CMUser;

@interface CMMapViewController : UIViewController <MKMapViewDelegate>
@property (nonatomic, retain)	CMUser	*user;

@end
