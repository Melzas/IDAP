#import "CWCarWashRoom.h"

#import "CWCar.h"
#import "CWCarWasher.h"

@interface CWCarWashRoom ()
@property (nonatomic, retain)		NSMutableArray	*mutableCars;

@end

@implementation CWCarWashRoom

@dynamic cars;

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
	self.mutableCars = nil;
	
	[super dealloc];
}

- (instancetype)initWithWorkerCapacity:(NSUInteger)workerCapacity {
	if ([super initWithWorkerCapacity:workerCapacity]) {
		self.mutableCars = [NSMutableArray array];
	}
	return self;
}

#pragma mark -
#pragma mark Accessors

- (NSArray *)cars {
	return [[self.mutableCars copy] autorelease];
}

#pragma mark -
#pragma mark Public

- (void)washCar:(CWCar *)car {
	CWCarWasher *freeCarWasher = (CWCarWasher *)self.freeWorker;
	if (freeCarWasher) {
		freeCarWasher.busy = YES;
		[freeCarWasher performSelectorInBackground:@selector(washCar:) withObject:car];
	} else {
		[self.mutableCars addObject:car];
	}
}

- (BOOL)addWorker:(CWWorker *)worker {
	if ([worker isMemberOfClass:[CWCarWasher class]]) {
		return [super addWorker:worker];
	}
	return NO;
}

#pragma mark -
#pragma mark CWJobAcceptance

- (void)jobCompletedByWorker:(CWWorker *)worker {
	if (0 == [self.mutableCars count]) {
		worker.busy = NO;
	} else {
		CWCarWasher *carWasher = (CWCarWasher *)worker;
		CWCar *car = self.mutableCars[0];
		[self.mutableCars removeObject:car];
		[carWasher performSelectorInBackground:@selector(washCar:) withObject:car];
	}
}

@end
