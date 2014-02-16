#import "CWDirector.h"

@implementation CWDirector

- (void)jobCompletedByWorker:(CWWorker *)worker {
	self.money += worker.money;
	NSLog(@"Director %@ got %lu dollars. Total: %lu", self.name, worker.money, self.money);
	worker.money = 0;
}

@end
