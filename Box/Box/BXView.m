#import "BXView.h"

static const NSUInteger kBXBoxSpeed = 5;

@interface BXView ()
@property (nonatomic, retain, readwrite)	UIView		*box;
@property (nonatomic, assign)				NSInteger	distance;

@end

@implementation BXView

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
	self.box = nil;
	
	[super dealloc];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.distance = self.frame.size.width - self.box.frame.size.width;
    }
    return self;
}

#pragma mark -
#pragma mark Accesors

- (void)setBoxCorner:(BXBoxCorner)boxCorner {
	_boxCorner = boxCorner;
	switch (_boxCorner) {
		case kBXUpperLeft:
			break;
		case kBXUpperRight:
			break;
		case kBXLowerLeft:
			break;
		case kBXLowerRight:
		default:
			break;
	}
}

#pragma mark -
#pragma mark Public

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

- (void)setBoxPosition:(BXBoxCorner)position animated:(BOOL)animated {
	
}

- (void)setBoxPosition:(BXBoxCorner)position
			  animated:(BOOL)animated
	 completionHandler:(BXCompletionBlock)completionBlock
{
	
}

@end
