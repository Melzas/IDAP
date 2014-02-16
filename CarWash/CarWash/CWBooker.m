#import "CWBooker.h"

@implementation CWBooker

#pragma mark -
#pragma mark Public

- (void)countMoney {
	NSLog(@"Booker %@ counts money: %lu", self.name, self.money);
	[self.moneyCollector jobCompletedByWorker:self];
}

#pragma mark -
#pragma mark CWJobAcceptance

- (void)jobCompletedByWorker:(CWWorker *)worker {
	self.money += worker.money;
	NSLog(@"Booker %@ got %lu dollars from %@", self.name, worker.money, worker.name);
	worker.money = 0;
	[self countMoney];
}

@end
