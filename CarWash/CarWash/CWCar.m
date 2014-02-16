#import "CWCar.h"

#import "CWWorker.h"

const NSUInteger kCWCarWashPrice = 200;

@implementation CWCar

#pragma mark -
#pragma mark Class Methods

+ (instancetype)car {
	return [[[self alloc] init] autorelease];
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)init {
	if (self = [super init]) {
		self.money = arc4random() % 500;
	}
	return self;
}

#pragma mark -
#pragma mark CWJobAcceptance

- (void)jobCompletedByWorker:(CWWorker *)worker {
	self.money -= kCWCarWashPrice;
	worker.money = kCWCarWashPrice;
}

@end
