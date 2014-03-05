#import "BXView.h"

static const NSTimeInterval kBXBoxAnimationDuration = 2.0f;

@interface BXView ()
@property (nonatomic, retain, readwrite)	UIView	*boxView;

- (CGPoint)pointForPosition:(BXBoxPosition)position;

@end

@implementation BXView

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
	self.boxView = nil;
	
	[super dealloc];
}

#pragma mark -
#pragma mark Accessors

- (void)setBoxPosition:(BXBoxPosition)position {
	[self setBoxPosition:position animated:NO];
}

#pragma mark -
#pragma mark Public

- (void)setBoxPosition:(BXBoxPosition)position animated:(BOOL)animated {
	[self setBoxPosition:position animated:animated completionHandler:nil];
}

- (void)setBoxPosition:(BXBoxPosition)position
			  animated:(BOOL)animated
	 completionHandler:(BXCompletionBlock)completionBlock
{
	NSTimeInterval animationDuration = animated ? kBXBoxAnimationDuration : 0.0f;
	
	[UIView animateWithDuration:animationDuration
					 animations:^{
						 CGPoint boxPoint = [self pointForPosition:position];
						 self.boxView.frame = (CGRect){boxPoint, self.boxView.frame.size};
					 }
					 completion:^(BOOL finished) {
						 _boxPosition = position;
						 if (completionBlock) {
							 completionBlock(finished);
						 }
					 }];
}

#pragma mark -
#pragma mark Private

- (CGPoint)pointForPosition:(BXBoxPosition)position {
	CGPoint frameOrigin = self.frame.origin;
	CGSize frameSize = self.frame.size;
	CGSize boxSize = self.boxView.frame.size;
	
	switch (position) {
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
