#import "CWBooker.h"

@interface CWBooker ()

@end

@implementation CWBooker

#pragma mark -
#pragma mark Public

- (void)countMoneyOfWorker:(CWWorker *)worker {
	sleep(arc4random_uniform(5));
	NSUInteger money = worker.money;
	self.money += money;
	worker.money -= money;
	NSLog(@"Booker %@ counts %lu dollars from %@", self.name, money, worker.name);
}

- (void)performInBackground:(id)object {
	@autoreleasepool {
		CWWorker *worker = (CWWorker *)object;
		[self countMoneyOfWorker:worker];
	}
}

- (void)performOnMainThread:(id)object {
	[self notifyObserversWithObservable:self];
}

- (void)didReceiveNotificationFromObservable:(id<IDPObservable>)observable {
	[self jobCompletedByWorker:(CWWorker *)observable];
}

#pragma mark -
#pragma mark CWJobAcceptance

- (void)jobCompletedByWorker:(CWWorker *)worker {
	[self addObjectToQueue:worker];
}

@end
