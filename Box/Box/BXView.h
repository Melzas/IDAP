#import <UIKit/UIKit.h>

typedef enum {
	kBXUpperLeft,
	kBXUpperRight,
	kBXLowerLeft,
	kBXLowerRight
} BXBoxCorner;

typedef void(^BXCompletionBlock)(BOOL completed);

@interface BXView : UIView
@property (nonatomic, readonly)	IBOutlet UIView	*box;
@property (nonatomic, assign)	BXBoxCorner		boxCorner;

- (void)animateBox;
- (void)setBoxPosition:(BXBoxCorner)position animated:(BOOL)animated;
- (void)setBoxPosition:(BXBoxCorner)position
			  animated:(BOOL)animated
	 completionHandler:(BXCompletionBlock)completionBlock;

@end
