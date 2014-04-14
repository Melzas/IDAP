//
//  FFLoginViewController.h
//  FacebookFriends
//
//  Created by Anton Rayev on 3/26/14.
//  Copyright (c) 2014 Anton Rayev. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FFLoginView;
@class FFUsers;

@interface FFLoginViewController : UIViewController <FBLoginViewDelegate>

- (IBAction)onProceed:(id)sender;

@end
