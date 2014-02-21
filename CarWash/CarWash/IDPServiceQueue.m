#import "IDPServiceQueue.h"

typedef void(^CWOperationBlock)(NSMutableArray *queue, id object);

@interface IDPServiceQueue ()
@property (atomic, retain)	NSMutableArray	*mutableQueue;

- (void)performSynchronizedOperationWithObject:(id)object operation:(CWOperationBlock)operation;

@end

@implementation IDPServiceQueue

@dynamic queue;

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
	self.mutableQueue = nil;
	
	[super dealloc];
}

- (id)init {
	if (self = [super init]) {
		self.mutableQueue = [NSMutableArray array];
	}
	return self;
}

#pragma mark -
#pragma mark Accessors

- (NSArray *)queue {
	__block NSArray *queueCopy;
	[self performSynchronizedOperationWithObject:nil operation:^(NSMutableArray *queue, id object) {
		queueCopy = [[queue copy] autorelease];
	}];
	return queueCopy;
}

#pragma mark -
#pragma mark Public

- (void)addObjectToQueue:(id)object {
	[self performSynchronizedOperationWithObject:object
									   operation:^(NSMutableArray *queue, id object) {
		if (NSNotFound == [queue indexOfObjectIdenticalTo:object]) {
			[queue addObject:object];
		}
	}];
	if (!self.isBusy) {
		self.busy = YES;
		[self processNextObjectInQueue];
	}
}

- (void)removeObjectFromQueue:(id)object {
	[self performSynchronizedOperationWithObject:object
									   operation:^(NSMutableArray *queue, id object) {
		[queue removeObject:object];
	}];
}

- (void)processNextObjectInQueue {
	id object = [self.queue firstObject];
	if (object) {
		[self performSelectorInBackground:@selector(performBackgroundTask:) withObject:object];
	} else {
		self.busy = NO;
	}
}

- (void)performBackgroundTask:(id)object {
	[self performSelectorOnMainThread:@selector(performMainThreadTask:)
						   withObject:object
						waitUntilDone:NO];
}

- (void)performMainThreadTask:(id)object {
	[self removeObjectFromQueue:object];
	[self processNextObjectInQueue];
}

#pragma mark -
#pragma mark Private

- (void)performSynchronizedOperationWithObject:(id)object operation:(CWOperationBlock)operation {
	@synchronized(self.mutableQueue) {
		operation(self.mutableQueue, object);
	}
}

@end
