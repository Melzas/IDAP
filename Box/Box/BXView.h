#import <UIKit/UIKit.h>

typedef enum {
	kBXUpperLeft,
	kBXUpperRight,
	kBXLowerLeft,
	kBXLowerRight
} BXBoxCorner;

@interface BXView : UIView
@property (nonatomic, readonly)	IBOutlet UIView	*box;
@property (nonatomic, assign)	BXBoxCorner		*boxCorner;

- (void)animateBox;

@end
