#import "IDPServiceQueue.h"

@interface IDPServiceQueue ()
@property (nonatomic, retain)	NSMutableArray	*mutableQueue;

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
	return [[self.mutableQueue copy] autorelease];
}

#pragma mark -
#pragma mark Public

- (void)addObjectToQueue:(id)object {
	if (NSNotFound == [self.mutableQueue indexOfObjectIdenticalTo:object]) {
		[self.mutableQueue addObject:object];
	}
	if (!self.isBusy) {
		self.busy = YES;
		[self processNextObjectInQueue];
	}
}

- (void)removeObjectFromQueue:(id)object {
	[self.mutableQueue removeObject:object];
}

- (void)processNextObjectInQueue {
	id object = [self.mutableQueue firstObject];
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

@end
