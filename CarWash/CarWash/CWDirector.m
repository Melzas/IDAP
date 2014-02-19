#import "CWDirector.h"

@interface CWDirector ()

- (void)gainProfitFromWorker:(CWWorker *)worker;
- (void)processQueue;

@end

@implementation CWDirector

#pragma mark -
#pragma mark Private

- (void)gainProfitFromWorker:(CWWorker *)worker {
	@autoreleasepool {
		sleep(arc4random_uniform(5));
		self.money += worker.money;
		NSLog(@"Director %@ got %lu dollars from %@. Total: %lu\n\n",
			  self.name,
			  worker.money,
			  worker.name,
			  self.money);
		worker.money = 0;
		
		[self performSelectorOnMainThread:@selector(removeWorkerFromQueue:)
							   withObject:worker
							waitUntilDone:YES];
		[self performSelectorOnMainThread:@selector(processQueue)
							   withObject:nil waitUntilDone:NO];
	}
}

- (void)processQueue {
	[self processQueueWithSelector:@selector(gainProfitFromWorker:)];
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
	}}

@end
