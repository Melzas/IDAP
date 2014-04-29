//
//  CMCompassView.h
//  Compo
//
//  Created by Anton Rayev on 4/25/14.
//  Copyright (c) 2014 Anton Rayev. All rights reserved.
//

@class CMCompass;
@class CMUser;
@class CMSwirlGestureRecognizer;

@interface CMCompassView : UIView
@property (nonatomic, retain)	IBOutlet CMCompass			*compass;
@property (nonatomic, retain)	CMSwirlGestureRecognizer	*swirlGestureRecognizer;

- (void)fillWithUser:(CMUser *)user;

@end
