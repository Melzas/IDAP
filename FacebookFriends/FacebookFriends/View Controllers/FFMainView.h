//
//  FFMainView.h
//  FacebookFriends
//
//  Created by Anton Rayev on 3/17/14.
//  Copyright (c) 2014 Anton Rayev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FFMainView : UIView
@property (nonatomic, retain)	IBOutlet FBLoginView	*loginView;
@property (nonatomic, retain)	IBOutlet UITableView	*tableView;

@end
