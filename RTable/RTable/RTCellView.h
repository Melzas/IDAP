#import <UIKit/UIKit.h>

@class RTCellModel;

@interface RTCellView : UITableViewCell

- (void)fillFromModel:(RTCellModel *)cellModel;

@end
