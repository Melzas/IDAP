#import <UIKit/UIKit.h>

#import "IDPModelObserver.h"

#import "FFFriendImageView.h"

@class FFUserData;

@interface FFFriendCell : UITableViewCell <IDPModelObserver>
@property (nonatomic, retain)	IBOutlet UILabel			*label;
@property (nonatomic, retain)	IBOutlet FFFriendImageView	*pictureView;
@property (nonatomic, retain)	FFUserData					*userData;

@end
