#import "CWRoom.h"

#import "CWWorker.h"

@interface CWRoom ()
@property (nonatomic, retain)		NSMutableArray	*mutableWorkers;
@property (nonatomic, readwrite)	NSUInteger		workerCapacity;

@end

@implementation CWRoom

@dynamic workers;

#pragma mark -
#pragma mark Class Methods

+ (instancetype)roomWithWorkerCapacity:(NSUInteger)workerCapacity {
	return [[[self alloc] initWithWorkerCapacity:workerCapacity] autorelease];
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
	self.mutableWorkers = nil;
	
	[super dealloc];
}

- (instancetype)init {
	return [self initWithWorkerCapacity:0];
}

- (instancetype)initWithWorkerCapacity:(NSUInteger)workerCapacity {
	if (self = [super init]) {
		self.workerCapacity = workerCapacity;
		self.mutableWorkers = [NSMutableArray arrayWithCapacity:workerCapacity];
	}
	return self;
}

#pragma mark -
#pragma mark Accessors

- (NSArray *)workers {
	return [[self.mutableWorkers copy] autorelease];
}

#pragma mark -
#pragma mark Public

- (BOOL)addWorker:(CWWorker *)worker {
	if ([self.mutableWorkers count] == self.workerCapacity) {
		return NO;
	}
	[self.mutableWorkers addObject:worker];
	return YES;
}

- (BOOL)removeWorker:(CWWorker *)worker {
	NSUInteger workerIndex = [self.mutableWorkers indexOfObjectIdenticalTo:worker];
	if (NSNotFound == workerIndex) {
		return NO;
	}
	[self.mutableWorkers removeObjectAtIndex:workerIndex];
	return YES;
}

- (CWWorker *)freeWorker {
	NSArray *workers = self.mutableWorkers;
	for (CWWorker *worker in workers) {
		if (!worker.isBusy) {
			return [[worker retain] autorelease];
		}
	}
	return nil;
}

@end
