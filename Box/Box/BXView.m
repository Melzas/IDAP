#import "BXView.h"

static const NSUInteger kBXBoxAnimationDuration = 2;

@interface BXView ()
@property (nonatomic, retain, readwrite)	UIView		*box;

@end

@implementation BXView

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
	self.box = nil;
	
	[super dealloc];
}

#pragma mark -
#pragma mark Accessors

- (void)setBoxCorner:(BXBoxCorner)boxCorner {
	_boxCorner = boxCorner;
	CGFloat x;
	CGFloat y;
	
	switch (_boxCorner) {
		case kBXUpperLeft:
			x = self.frame.origin.x;
			y = self.frame.origin.y;
			break;
		case kBXUpperRight:
			x = self.frame.origin.x + self.frame.size.width - self.box.frame.size.width;
			y = self.frame.origin.y;
			break;
		case kBXLowerLeft:
			x = self.frame.origin.x;
			y = self.frame.origin.y + self.frame.size.height - self.box.frame.size.height;
			break;
		case kBXLowerRight:
			x = self.frame.origin.x + self.frame.size.width - self.box.frame.size.width;
			y = self.frame.origin.y + self.frame.size.height - self.box.frame.size.height;
		default:
			break;
	}
	CGPoint cornerPoint = CGPointMake(x, y);
	CGSize boxSize = CGSizeMake(self.box.frame.size.width, self.box.frame.size.height);
	self.box.frame = (CGRect){cornerPoint, boxSize};
}

#pragma mark -
#pragma mark Public

- (void)setBoxPosition:(BXBoxCorner)position animated:(BOOL)animated {
	[self setBoxPosition:position animated:animated completionHandler:nil];
}

- (void)setBoxPosition:(BXBoxCorner)position
			  animated:(BOOL)animated
	 completionHandler:(BXCompletionBlock)completionBlock
{
	if (animated) {
		[UIView animateWithDuration:kBXBoxAnimationDuration
						 animations:^{
							 self.boxCorner = position;
						 }
						 completion:^(BOOL finished) {
							 if (completionBlock) {
								 completionBlock(finished);
							 }
						 }];
	} else {
		dispatch_async(dispatch_get_main_queue(), ^{
			self.boxCorner = position;
			if (completionBlock) {
				completionBlock(YES);
			}
		});
	}
}

@end
