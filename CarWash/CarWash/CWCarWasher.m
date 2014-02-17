#import "CWCarWasher.h"

@implementation CWCarWasher

#pragma mark -
#pragma mark Public

- (void)washCar:(CWCar *)car {
	dispatch_async(dispatch_get_main_queue(), ^{
		sleep(arc4random_uniform(5));
		NSLog(@"%@ washes %@", self.name, car.name);
		car.cleanness = kCWClean;
		[car jobCompletedByWorker:self];
		[self.moneyCollector jobCompletedByWorker:self];
	});
}

@end
