#import <UIKit/UIKit.h>

#import "IDPModelObserver.h"

#import "FFImageView.h"

@class FFUserData;

@interface FFCellView : UITableViewCell <IDPModelObserver>
@property (nonatomic, retain)	IBOutlet UILabel		*label;
@property (nonatomic, retain)	IBOutlet FFImageView	*pictureView;
@property (nonatomic, retain)	FFUserData				*userData;

@end
