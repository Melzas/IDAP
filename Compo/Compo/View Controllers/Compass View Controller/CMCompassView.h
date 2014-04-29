//
//  CMCompassView.h
//  Compo
//
//  Created by Anton Rayev on 4/25/14.
//  Copyright (c) 2014 Anton Rayev. All rights reserved.
//

@class CMCompass;
@class CMUser;

@interface CMCompassView : UIView
@property (nonatomic, retain)	IBOutlet CMCompass	*compass;

- (void)fillWithUser:(CMUser *)user;

@end
