#import "CWCarWasher.h"

@interface CWCarWasher ()

- (void)washCarInBackground:(CWCar *)car;

@end

@implementation CWCarWasher

#pragma mark -
#pragma mark Public

- (void)washCar:(CWCar *)car {
	[self performSelectorInBackground:@selector(washCarInBackground:) withObject:car];
}

#pragma mark -
#pragma mark Private

- (void)washCarInBackground:(CWCar *)car {
	@autoreleasepool {
		sleep(arc4random_uniform(5));
		NSLog(@"%@ washes %@", self.name, car.name);
		car.cleanness = kCWClean;
		[car performSelectorOnMainThread:@selector(jobCompletedByWorker:)
							  withObject:self
						   waitUntilDone:YES];
		[self.moneyCollector performSelectorOnMainThread:@selector(jobCompletedByWorker:)
											  withObject:self
										   waitUntilDone:NO];
	}
}

@end
