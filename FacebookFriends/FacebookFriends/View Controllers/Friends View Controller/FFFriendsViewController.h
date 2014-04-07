//
//  FFMainViewController.h
//  FacebookFriends
//
//  Created by Anton Rayev on 3/17/14.
//  Copyright (c) 2014 Anton Rayev. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FFUsers;
@class FFFriendDetailsViewController;

@interface FFFriendsViewController : UIViewController <IDPModelObserver,
													   UITableViewDataSource,
													   UITableViewDelegate>

@property (nonatomic, retain)	FFUsers	*users;

@end
