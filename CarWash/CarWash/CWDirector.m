#import "CWDirector.h"

@implementation CWDirector

#pragma mark -
#pragma mark CWJobAcceptance

- (void)jobCompletedByWorker:(CWWorker *)worker {
	dispatch_async(dispatch_get_main_queue(), ^{
		sleep(arc4random_uniform(5));
		self.money += worker.money;
		NSLog(@"Director %@ got %lu dollars from %@. Total: %lu\n\n",
			  self.name,
			  worker.money,
			  worker.name,
			  self.money);
		worker.money = 0;
	});
}

@end
