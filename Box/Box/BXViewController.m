#import "BXViewController.h"

#import "BXView.h"

@interface BXViewController ()

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
	return (BXView*)self.view;
}

#pragma mark -
#pragma mark Public

- (void)animateBox {
	[self.boxView setBoxPosition:kBXLowerRight
						animated:YES
			   completionHandler:^(BOOL completed) {
				   [self.boxView setBoxPosition:kBXLowerLeft
									   animated:NO
							  completionHandler:^(BOOL completed) {
								  [self.boxView setBoxPosition:kBXUpperLeft
													  animated:YES
											 completionHandler:^(BOOL completed) {
												 [self.boxView setBoxPosition:kBXUpperRight
																	 animated:YES
															completionHandler:^(BOOL completed) {
																[self animateBox];
															}];
											 }];
							  }];
			   }];
}

@end
