//
//  FFFriendDetailsView.h
//  FacebookFriends
//
//  Created by Anton Rayev on 3/27/14.
//  Copyright (c) 2014 Anton Rayev. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FFFriendImageView;
@class FFUserData;

@interface FFFriendDetailsView : UIView
@property (nonatomic, retain)	IBOutlet FFFriendImageView	*friendImageView;
@property (nonatomic, retain)	IBOutlet UILabel			*firstNameLabel;
@property (nonatomic, retain)	IBOutlet UILabel			*lastNameLabel;
@property (nonatomic, retain)	IBOutlet UILabel			*locationLabel;

- (void)fillFromModel:(FFUserData *)userData;

@end
