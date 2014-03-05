#import "BXViewController.h"

#import "BXView.h"

static const BXBoxPosition kBXPositionSequence[] = {
	kBXLowerRight,
	kBXLowerLeft,
	kBXUpperRight,
	kBXUpperLeft
};
static const NSUInteger kBXPositionSequenceSize = sizeof(kBXPositionSequence)
	/ sizeof(kBXPositionSequence[0]);

@interface BXViewController ()
@property (nonatomic, assign)	NSUInteger	currentCornerIndex;

- (void)animateBox;

@end

@implementation BXViewController

@dynamic mainView;

#pragma mark -
#pragma mark View Lifecycle

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	[self animateBox];
}

#pragma mark -
#pragma mark Accessors

- (BXView *)mainView {
	if ([self isViewLoaded] && [self.view isKindOfClass:[BXView class]]) {
		return (BXView *)self.view;
	}
	
	return nil;
}

#pragma mark -
#pragma mark Public

- (void)animateBox {
	[self.mainView setBoxPosition:kBXPositionSequence[self.currentCornerIndex]
						animated:YES
			   completionHandler:^(BOOL completed) {
				   ++self.currentCornerIndex;
				   if (kBXPositionSequenceSize == self.currentCornerIndex) {
					   self.currentCornerIndex = 0;
				   }
				   [self animateBox];
			   }];
}

@end
