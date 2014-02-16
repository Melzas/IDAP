#import "CWBooker.h"

@implementation CWBooker

- (void)countMoney {
	NSLog(@"Booker %@ got %lu dollars", self.name, self.money);
	[self.moneyCollector jobCompletedByWorker:self];
}

- (void)jobCompletedByWorker:(CWWorker *)worker {
	self.money += worker.money;
	worker.money = 0;
	[self countMoney];
}

@end
