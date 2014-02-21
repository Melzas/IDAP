#import "CWDirector.h"

@interface CWDirector ()

- (void)gainProfitFromWorker:(CWWorker *)worker;

@end

@implementation CWDirector

#pragma mark -
#pragma mark Public

- (void)gainProfitFromWorker:(CWWorker *)worker {
	sleep(arc4random_uniform(5));
	NSUInteger money = worker.money;
	self.money += money;
	worker.money -= money;
	NSLog(@"Director %@ got %lu dollars from %@. Total: %lu\n\n",
		  self.name,
		  money,
		  worker.name,
		  self.money);
}

- (void)performBackgroundTask:(id)object {
	@autoreleasepool {
		CWWorker *worker = (CWWorker *)object;
		[self gainProfitFromWorker:worker];
		[super performBackgroundTask:worker];
	}
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
