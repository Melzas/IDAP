#import <UIKit/UIKit.h>

@class BXView;

@interface BXViewController : UIViewController
@property (nonatomic, readonly)	BXView	*boxView;

- (void)animateBox;

@end