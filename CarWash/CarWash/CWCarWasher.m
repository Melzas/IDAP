#import "CWCarWasher.h"

@implementation CWCarWasher

- (void)washCar:(CWCar *)car {
	car.cleanness = kCWClean;
	[car jobCompletedByWorker:self];
	[self.moneyCollector jobCompletedByWorker:self];
}

@end
