#import "CWBooker.h"

@implementation CWBooker

#pragma mark -
#pragma mark Public

- (void)countMoney {
	@autoreleasepool {
		sleep(arc4random_uniform(5));
		NSLog(@"Booker %@ counts money: %lu", self.name, self.money);
		[self.moneyCollector performSelectorOnMainThread:@selector(jobCompletedByWorker:)
											  withObject:self
										   waitUntilDone:NO];
	}
}

#pragma mark -
#pragma mark CWJobAcceptance

- (void)jobCompletedByWorker:(CWWorker *)worker {
	self.money += worker.money;
	NSLog(@"Booker %@ got %lu dollars from %@", self.name, worker.money, worker.name);
	worker.money = 0;
	[self performSelectorInBackground:@selector(countMoney) withObject:nil];
}

@end
