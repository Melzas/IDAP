//
//  FFLoginView.h
//  FacebookFriends
//
//  Created by Anton Rayev on 3/26/14.
//  Copyright (c) 2014 Anton Rayev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FFLoginView : UIView
@property (nonatomic, retain)	IBOutlet UILabel				*loggedInLabel;
@property (nonatomic, retain)	IBOutlet UILabel				*usernameLabel;
@property (nonatomic, retain)	IBOutlet FBProfilePictureView	*profilePictureView;
@property (nonatomic, retain)	IBOutlet FBLoginView			*loginView;
@property (nonatomic, retain)	IBOutlet UIButton				*proceedButton;

- (void)fillWithUser:(id<FBGraphUser>)user;
- (void)clearUser;

@end
