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
	
	CGPoint frameOrigin = self.frame.origin;
	CGSize frameSize = self.frame.size;
	CGSize boxSize = self.box.frame.size;
	
	CGFloat x;
	CGFloat y;
	
	switch (_boxCorner) {
		case kBXUpperLeft:
			x = frameOrigin.x;
			y = frameOrigin.y;
			break;
		case kBXUpperRight:
			x = frameOrigin.x + frameSize.width - boxSize.width;
			y = self.frame.origin.y;
			break;
		case kBXLowerLeft:
			x = frameOrigin.x;
			y = frameOrigin.y + frameSize.height - boxSize.height;
			break;
		case kBXLowerRight:
			x = frameOrigin.x + frameSize.width - boxSize.width;
			y = frameOrigin.y + frameSize.height - boxSize.height;
		default:
			break;
	}
	
	CGPoint cornerPoint = CGPointMake(x, y);
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
