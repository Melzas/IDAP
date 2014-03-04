#import "BXViewController.h"

#import "BXView.h"

static const BXBoxCorner kBXCornerSequence[] = {
	kBXLowerRight,
	kBXLowerLeft,
	kBXUpperRight,
	kBXUpperLeft
};
static const NSUInteger kBXCornerSequenceSize = sizeof(kBXCornerSequence)
	/ sizeof(kBXCornerSequence[0]);

@interface BXViewController ()
@property (nonatomic, assign)	NSUInteger	currentCornerIndex;

- (void)animateBox;

@end

@implementation BXViewController

@dynamic boxView;

#pragma mark -
#pragma mark View Lifecycle

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	[self animateBox];
}

#pragma mark -
#pragma mark Accessors

- (BXView *)boxView {
	if ([self isViewLoaded] && [self.view isKindOfClass:[BXView class]]) {
		return (BXView *)self.view;
	}
	return nil;
}

#pragma mark -
#pragma mark Public

- (void)animateBox {
	[self.boxView setBoxPosition:kBXCornerSequence[self.currentCornerIndex]
						animated:YES
			   completionHandler:^(BOOL completed) {
				   ++self.currentCornerIndex;
				   if (kBXCornerSequenceSize == self.currentCornerIndex) {
					   self.currentCornerIndex = 0;
				   }
				   [self animateBox];
			   }];
}

@end
