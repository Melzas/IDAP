//
//  FFMainViewController.h
//  FacebookFriends
//
//  Created by Anton Rayev on 3/17/14.
//  Copyright (c) 2014 Anton Rayev. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FFUsersData;

@interface FFMainViewController : UIViewController
	<IDPModelObserver, UITableViewDataSource, FBLoginViewDelegate>
@property (nonatomic, retain)	FFUsersData	*usersData;

@end
