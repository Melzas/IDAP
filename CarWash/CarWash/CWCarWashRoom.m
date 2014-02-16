#import "CWCarWashRoom.h"

#import "CWCar.h"
#import "CWCarWasher.h"

@interface CWCarWashRoom ()
@property (nonatomic, retain)		NSMutableArray	*mutableCars;
@property (nonatomic, readwrite)	NSUInteger		carCapacity;

@end

@implementation CWCarWashRoom

@dynamic cars;

#pragma mark -
#pragma mark Class Methods

+ (instancetype)roomWithWorkerCapacity:(NSUInteger)workerCapacity
						   carCapacity:(NSUInteger)carCapacity
{
	id room = [[self alloc] initWithWorkerCapacity:workerCapacity carCapacity:carCapacity];
	return [room autorelease];
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
	self.mutableCars = nil;
	
	[super dealloc];
}

- (instancetype)initWithWorkerCapacity:(NSUInteger)workerCapacity
						   carCapacity:(NSUInteger)carCapacity
{
	self = [super initWithWorkerCapacity:workerCapacity];
	if (self) {
		self.carCapacity = carCapacity;
		self.mutableCars = [NSMutableArray arrayWithCapacity:carCapacity];
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

- (BOOL)addCar:(CWCar *)car {
	if ([self.mutableCars count] == self.carCapacity) {
		return NO;
	}
	[self.mutableCars addObject:car];
	return YES;
}

- (void)washAllCars {
	for (CWCar *car in self.mutableCars) {
		CWCarWasher *randomCarWasher = (CWCarWasher *)[self randomWorker];
		[randomCarWasher washCar:car];
	}
	[self.mutableCars removeAllObjects];
}

- (BOOL)addWorker:(CWWorker *)worker {
	if ([worker isMemberOfClass:[CWCarWasher class]]) {
		return [super addWorker:worker];
	}
	return NO;
}

@end
