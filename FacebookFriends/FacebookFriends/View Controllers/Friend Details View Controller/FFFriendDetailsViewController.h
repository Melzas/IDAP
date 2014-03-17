//
//  FFFriendDetailsViewController.h
//  FacebookFriends
//
//  Created by Anton Rayev on 3/27/14.
//  Copyright (c) 2014 Anton Rayev. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FFUser;
@class FFFriendDetailsView;

@interface FFFriendDetailsViewController : UIViewController <IDPModelObserver>
@property (nonatomic, retain)	FFUser	*user;

@end
