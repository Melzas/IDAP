#import "CWCarWasher.h"

@implementation CWCarWasher

#pragma mark -
#pragma mark Public

- (void)washCar:(CWCar *)car {
	[self addObjectToQueue:car];
}

- (void)performBackgroundTask:(id)object {
	@autoreleasepool {
		sleep(arc4random_uniform(5));
		CWCar *car = (CWCar *)object;
		NSLog(@"%@ washes %@", self.name, car.name);
		car.cleanness = kCWClean;
		[super performBackgroundTask:car];
	}
}

- (void)performMainThreadTask:(id)object {
	[object jobCompletedByWorker:self];
	[self notifyObserversWithObservable:self];
	[super performMainThreadTask:object];
}

@end
