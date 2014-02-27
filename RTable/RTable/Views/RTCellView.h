#import <UIKit/UIKit.h>

#import "IDPModelObserver.h"

#import "RTImageView.h"

@class RTCellModel;

@interface RTCellView : UITableViewCell <IDPModelObserver>
@property (nonatomic, retain)	IBOutlet UILabel		*label;
@property (nonatomic, retain)	IBOutlet RTImageView	*asyncImageView;
@property (nonatomic, retain)	RTCellModel				*model;

@end
