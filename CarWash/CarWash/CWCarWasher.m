#import "CWCarWasher.h"

@implementation CWCarWasher

#pragma mark -
#pragma mark Public

- (void)washCar:(CWCar *)car {
	@autoreleasepool {
		sleep(arc4random_uniform(5));
		NSLog(@"%@ washes %@", self.name, car.name);
		car.cleanness = kCWClean;
		[car performSelectorOnMainThread:@selector(jobCompletedByWorker:)
							  withObject:self
						   waitUntilDone:YES];
		[self performSelectorOnMainThread:@selector(notify)
											  withObject:nil
										   waitUntilDone:NO];
	}
}

@end
