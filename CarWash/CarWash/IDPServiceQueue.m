#import "IDPServiceQueue.h"

typedef void(^CWOperationBlock)(NSMutableArray *queue);

@interface IDPServiceQueue ()
@property (atomic, retain)	NSMutableArray	*mutableQueue;

- (void)performBackgroundTask:(id)object;
- (void)performMainThreadTask:(id)object;

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

- (void)addObjectToQueue:(id<IDPQueueable>)object {
	[self performSynchronizedOperation:^(NSMutableArray *queue) {
		if (![queue containsObject:object]) {
			[object setInQueue:YES];
			[queue addObject:object];
		}
	}];
	
	[self processNextObjectInQueue];
}

- (void)removeObjectFromQueue:(id<IDPQueueable>)object {
	[self performSynchronizedOperation:^(NSMutableArray *queue) {
		[queue removeObjectIdenticalTo:object];
		[object setInQueue:NO];
	}];
	
	self.busy = NO;
	if ([object isKindOfClass:[IDPServiceQueue class]]) {
		[(IDPServiceQueue*)object processNextObjectInQueue];
	}
}

- (void)processNextObjectInQueue {
	id object = [self.queue firstObject];
	if (object && !self.busy && !self.inQueue) {
		self.busy = YES;
		[self performSelectorInBackground:@selector(performBackgroundTask:) withObject:object];
	}
}

- (void)performInBackground:(id)object {
	
}

- (void)performOnMainThread:(id)object {
	
}

#pragma mark -
#pragma mark Private

- (void)performBackgroundTask:(id)object {
	[self performInBackground:object];
	[self performSelectorOnMainThread:@selector(performMainThreadTask:)
						   withObject:object
						waitUntilDone:NO];
}

- (void)performMainThreadTask:(id)object {
	[self performOnMainThread:object];
	[self removeObjectFromQueue:object];
	[self processNextObjectInQueue];
}


- (void)performSynchronizedOperation:(CWOperationBlock)operation {
	@synchronized(self) {
		operation(self.mutableQueue);
	}
}

@end
