#import "CWBooker.h"

@interface CWBooker ()

@end

@implementation CWBooker

#pragma mark -
#pragma mark Public

- (void)countMoneyOfWorker:(CWWorker *)worker {
	sleep(arc4random_uniform(5));
	self.money += worker.money;
	NSLog(@"Booker %@ counts %lu dollars from %@", self.name, worker.money, worker.name);
	worker.money = 0;
}

- (void)performBackgroundTask:(id)object {
	@autoreleasepool {
		CWWorker *worker = (CWWorker *)object;
		[self countMoneyOfWorker:worker];
		[super performBackgroundTask:worker];
	}
}

- (void)performMainThreadTask:(id)object {
	[self notify];
	[super performMainThreadTask:object];
}

#pragma mark -
#pragma mark CWJobAcceptance

- (void)jobCompletedByWorker:(CWWorker *)worker {
	[self addObjectToQueue:worker];
}

@end
