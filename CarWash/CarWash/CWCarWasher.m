#import "CWCarWasher.h"

@implementation CWCarWasher

#pragma mark -
#pragma mark Public

- (void)washCar:(CWCar *)car {
	car.cleanness = kCWClean;
	[car jobCompletedByWorker:self];
	[self.moneyCollector jobCompletedByWorker:self];
}

@end
