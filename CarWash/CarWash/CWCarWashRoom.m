#import "CWCarWashRoom.h"

#import "CWCar.h"
#import "CWCarWasher.h"

@implementation CWCarWashRoom

#pragma mark -
#pragma mark Public

- (void)addCar:(CWCar *)car {
	CWCarWasher *freeCarWasher = (CWCarWasher *)[self freeWorker];
	if (freeCarWasher) {
		[freeCarWasher washCar:car];
	} else {
		CWCarWasher *randomCarWasher = (CWCarWasher *)[self randomWorker];
		[randomCarWasher washCar:car];
	}
}

- (BOOL)addWorker:(CWWorker *)worker {
	if ([worker isMemberOfClass:[CWCarWasher class]]) {
		return [super addWorker:worker];
	}
	return NO;
}

@end
