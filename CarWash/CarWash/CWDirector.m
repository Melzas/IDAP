#import "CWDirector.h"

@interface CWDirector ()

- (void)gainProfitFromWorker:(CWWorker *)worker;

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
	}
}

#pragma mark -
#pragma mark CWJobAcceptance

- (void)jobCompletedByWorker:(CWWorker *)worker {
	[self performSelectorInBackground:@selector(gainProfitFromWorker:) withObject:worker];
}

@end
