#import <UIKit/UIKit.h>

#import "IDPModelObserver.h"

@class RTCellModel;

@interface RTCellView : UITableViewCell <IDPModelObserver>
@property (nonatomic, retain)	IBOutlet UILabel					*textLabel;
@property (nonatomic, retain)	IBOutlet UIImageView				*imageView;
@property (nonatomic, retain)	IBOutlet UIActivityIndicatorView	*spinner;

@end
