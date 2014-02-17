#import "CWBooker.h"

@implementation CWBooker

#pragma mark -
#pragma mark Public

- (void)countMoney {
	dispatch_async(dispatch_get_main_queue(), ^{
		sleep(arc4random_uniform(5));
		NSLog(@"Booker %@ counts money: %lu", self.name, self.money);
		[self.moneyCollector jobCompletedByWorker:self];
	});
}

#pragma mark -
#pragma mark CWJobAcceptance

- (void)jobCompletedByWorker:(CWWorker *)worker {
	dispatch_async(dispatch_get_main_queue(), ^{
		sleep(arc4random_uniform(5));
		self.money += worker.money;
		NSLog(@"Booker %@ got %lu dollars from %@", self.name, worker.money, worker.name);
		worker.money = 0;
		[self countMoney];
	});
}

@end
