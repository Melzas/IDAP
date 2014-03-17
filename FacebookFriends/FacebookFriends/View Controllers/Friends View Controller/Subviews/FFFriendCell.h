#import <UIKit/UIKit.h>

#import "IDPModelObserver.h"

#import "FFImageView.h"

@class FFUser;

@interface FFFriendCell : UITableViewCell <IDPModelObserver>
@property (nonatomic, retain)	IBOutlet UILabel		*label;
@property (nonatomic, retain)	IBOutlet FFImageView	*pictureView;
@property (nonatomic, retain)	FFUser					*user;

@end
