#import <UIKit/UIKit.h>

typedef enum {
	kBXUpperLeft,
	kBXUpperRight,
	kBXLowerLeft,
	kBXLowerRight
} BXBoxPosition;

typedef void(^BXCompletionBlock)(BOOL completed);

@interface BXView : UIView
@property (nonatomic, readonly)	IBOutlet UIView		*boxView;
@property (nonatomic, assign)	BXBoxPosition		boxPosition;

- (void)setBoxPosition:(BXBoxPosition)position animated:(BOOL)animated;

- (void)setBoxPosition:(BXBoxPosition)position
			  animated:(BOOL)animated
	 completionHandler:(BXCompletionBlock)completionBlock;

@end
