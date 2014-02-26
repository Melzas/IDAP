#import "BXViewController.h"

#import "BXView.h"

static const BXBoxCorner kBXCornerSequence[] = {
	kBXLowerRight,
	kBXLowerLeft,
	kBXUpperRight,
	kBXUpperLeft
};
static const NSUInteger kBXCornerSequenceCount = sizeof(kBXCornerSequence)
	/ sizeof(kBXCornerSequence[0]);

@interface BXViewController ()
@property (nonatomic, assign)	NSUInteger	currentCornerIndex;

@end

@implementation BXViewController

@dynamic boxView;

#pragma mark -
#pragma mark View Lifecycle

- (void)viewDidAppear:(BOOL)animated {
	[self animateBox];
}

#pragma mark -
#pragma mark Accessors

- (BXView *)boxView {
	return (BXView *)self.view;
}

#pragma mark -
#pragma mark Public

- (void)animateBox {
	[self.boxView setBoxPosition:kBXCornerSequence[self.currentCornerIndex]
						animated:YES
			   completionHandler:^(BOOL completed) {
				   ++self.currentCornerIndex;
				   if (kBXCornerSequenceCount == self.currentCornerIndex) {
					   self.currentCornerIndex = 0;
				   }
				   [self animateBox];
			   }];
}

@end
