#import "CWCarWasher.h"

@implementation CWCarWasher

#pragma mark -
#pragma mark Public

- (void)washCar:(CWCar *)car {
	NSLog(@"%@ washes %@", self.name, car.name);
	car.cleanness = kCWClean;
	[car jobCompletedByWorker:self];
	[self.moneyCollector jobCompletedByWorker:self];
}

@end
