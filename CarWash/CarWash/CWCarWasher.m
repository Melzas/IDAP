#import "CWCarWasher.h"

@implementation CWCarWasher

#pragma mark -
#pragma mark Public

- (void)washCar:(CWCar *)car {
	[self addObjectToQueue:car];
}

- (void)performInBackground:(id)object {
	@autoreleasepool {
		sleep(arc4random_uniform(kCWWorkerMaxDelay));
		CWCar *car = (CWCar *)object;
		NSLog(@"%@ washes %@", self.name, car.name);
		car.cleanness = kCWClean;
	}
}

- (void)performOnMainThread:(id)object {
	[object jobCompletedByWorker:self];
	[self notifyObserversWithObservable:self];
}

@end
