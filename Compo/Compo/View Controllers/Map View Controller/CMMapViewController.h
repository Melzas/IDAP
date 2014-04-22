//
//  CMMapViewController.h
//  Compo
//
//  Created by Anton on 22.04.14.
//  Copyright (c) 2014 Anton Rayev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CMMapViewController : UIViewController

- (NSArray *)createAnnotationsAroundCoordinate:(CLLocationCoordinate2D)coordinate;

@end
