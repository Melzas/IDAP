//
//  CMCompassViewController.h
//  Compo
//
//  Created by Anton Rayev on 4/25/14.
//  Copyright (c) 2014 Anton Rayev. All rights reserved.
//

@class CMUser;

@interface CMCompassViewController : UIViewController
@property (nonatomic, retain)	CMUser	*user;

- (IBAction)handleGesture:(UIRotationGestureRecognizer *)gestureRecognizer;

@end
