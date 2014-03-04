#import "BXView.h"

static const NSTimeInterval kBXBoxAnimationDuration = 2.0f;

@interface BXView ()
@property (nonatomic, retain, readwrite)	UIView		*box;

- (CGPoint)pointForCorner:(BXBoxCorner)corner;

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
	CGPoint boxPoint = [self pointForCorner:boxCorner];
	self.box.frame = (CGRect){boxPoint, self.box.frame.size};
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

- (CGPoint)pointForCorner:(BXBoxCorner)corner {
	CGPoint frameOrigin = self.frame.origin;
	CGSize frameSize = self.frame.size;
	CGSize boxSize = self.box.frame.size;
	
	switch (corner) {
		case kBXUpperLeft:
			return CGPointMake(frameOrigin.x,
							   frameOrigin.y);
		case kBXUpperRight:
			return CGPointMake(frameOrigin.x + frameSize.width - boxSize.width,
							   frameOrigin.y);
		case kBXLowerLeft:
			return CGPointMake(frameOrigin.x,
							   frameOrigin.y + frameSize.height - boxSize.height);
		case kBXLowerRight:
			return CGPointMake(frameOrigin.x + frameSize.width - boxSize.width,
							   frameOrigin.y + frameSize.height - boxSize.height);
	}
	
	return CGPointZero;
}

@end
