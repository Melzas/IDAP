#import "IDPServiceQueue.h"

typedef void(^CWOperationBlock)(NSMutableArray *queue);

@interface IDPServiceQueue ()
@property (atomic, retain)	NSMutableArray	*mutableQueue;

- (void)performSynchronizedOperation:(CWOperationBlock)operation;

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
	[self performSynchronizedOperation:^(NSMutableArray *queue) {
		queueCopy = [[queue copy] autorelease];
	}];
	return queueCopy;
}

#pragma mark -
#pragma mark Public

- (void)addObjectToQueue:(id)object {
	[self performSynchronizedOperation:^(NSMutableArray *queue) {
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
	[self performSynchronizedOperation:^(NSMutableArray *queue) {
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

- (void)performSynchronizedOperation:(CWOperationBlock)operation {
	@synchronized(self) {
		operation(self.mutableQueue);
	}
}

@end
