#import "CWDirector.h"

@interface CWDirector ()

- (void)gainProfitFromWorker:(CWWorker *)worker;

@end

@implementation CWDirector

#pragma mark -
#pragma mark Private

- (void)gainProfitFromWorker:(CWWorker *)worker {
	sleep(arc4random_uniform(5));
	self.money += worker.money;
	NSLog(@"Director %@ got %lu dollars from %@. Total: %lu\n\n",
		  self.name,
		  worker.money,
		  worker.name,
		  self.money);
	worker.money = 0;
}

- (void)performBackgroundTask:(id)object {
	@autoreleasepool {
		CWWorker *worker = (CWWorker *)object;
		[self gainProfitFromWorker:worker];
		[super performBackgroundTask:worker];
	}
}

#pragma mark -
#pragma mark CWJobAcceptance

- (void)jobCompletedByWorker:(CWWorker *)worker {
	[self addObjectToQueue:worker];
}
@end
