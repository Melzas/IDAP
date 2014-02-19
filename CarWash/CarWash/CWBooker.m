#import "CWBooker.h"

@interface CWBooker ()

- (void)processQueue;

@end

@implementation CWBooker

#pragma mark -
#pragma mark Public

- (void)countMoneyOfWorker:(CWWorker *)worker {
	@autoreleasepool {
		sleep(arc4random_uniform(5));
		self.money += worker.money;
		NSLog(@"Booker %@ counts %lu dollars from %@", self.name, worker.money, worker.name);
		worker.money = 0;
		[self performSelectorOnMainThread:@selector(notify)
							   withObject:nil
							waitUntilDone:NO];
		[self performSelectorOnMainThread:@selector(removeWorkerFromQueue:)
							   withObject:worker
							waitUntilDone:YES];
		[self performSelectorOnMainThread:@selector(processQueue)
							   withObject:nil waitUntilDone:NO];
	}
}

- (void)processQueue {
	[self processQueueWithSelector:@selector(countMoneyOfWorker:)];
}

#pragma mark -
#pragma mark CWJobAcceptance

- (void)jobCompletedByWorker:(CWWorker *)worker {
	if (NSNotFound == [self.serviceQueue indexOfObjectIdenticalTo:worker]) {
		[self addWorkerToQueue:worker];
	}
	if (!self.isBusy) {
		self.busy = YES;
		[self processQueue];
	}
}

@end
