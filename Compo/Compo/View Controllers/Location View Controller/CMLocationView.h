//
//  CMLocationView.h
//  Compo
//
//  Created by Anton Rayev on 4/25/14.
//  Copyright (c) 2014 Anton Rayev. All rights reserved.
//

@class CMUser;

@interface CMLocationView : UIView
@property (nonatomic, retain)	IBOutlet UILabel	*coordinateLabel;
@property (nonatomic, retain)	IBOutlet UILabel	*countryLabel;
@property (nonatomic, retain)	IBOutlet UILabel	*stateLabel;
@property (nonatomic, retain)	IBOutlet UILabel	*cityLabel;
@property (nonatomic, retain)	IBOutlet UILabel	*streetLabel;
@property (nonatomic, retain)	IBOutlet UILabel	*postalCodeLabel;

- (void)fillWithUser:(CMUser *)user;

@end
