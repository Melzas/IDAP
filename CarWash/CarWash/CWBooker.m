#import "CWBooker.h"

@implementation CWBooker

#pragma mark -
#pragma mark Public

- (void)countMoney {
	NSLog(@"Booker %@ got %lu dollars", self.name, self.money);
	[self.moneyCollector jobCompletedByWorker:self];
}

#pragma mark -
#pragma mark CWJobAcceptance

- (void)jobCompletedByWorker:(CWWorker *)worker {
	self.money += worker.money;
	worker.money = 0;
	[self countMoney];
}

@end
