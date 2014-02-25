#import "BXViewController.h"

static const NSUInteger kBXBoxSpeed = 5;
static const CGRect	kBXBoxFrame = {{0, 250}, {20, 20}};

@interface BXViewController ()
@property (nonatomic, retain, readwrite)	UIView		*box;
@property (nonatomic, assign)				NSInteger	distance;

- (void)animateBox;

@end

@implementation BXViewController

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
	self.box = nil;
	
	[super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

#pragma mark -
#pragma mark View Lifecycle

- (void)loadView {
	self.view = [[[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
	self.box = [[[UIView alloc] initWithFrame:kBXBoxFrame] autorelease];
	self.distance = self.view.frame.size.width - self.box.frame.size.width;
	self.box.backgroundColor = [UIColor blackColor];
	[self.view addSubview:self.box];
}

- (void)viewDidAppear:(BOOL)animated {
	[self animateBox];
}

#pragma mark -
#pragma mark Private

- (void)animateBox {
	[UIView animateWithDuration:kBXBoxSpeed
					 animations:^{
						CGRect boxFrame = self.box.frame;
						boxFrame.origin.x += self.distance;
						self.box.frame = boxFrame;
					 }
					 completion:^(BOOL finished) {
						self.distance = -self.distance;
						[self animateBox];
					 }];
}

@end
