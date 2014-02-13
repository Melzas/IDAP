#import "IDPObservable.h"

#import "IDPObserverProtocol.h"

@interface IDPObservable ()
@property (nonatomic, retain)	NSMutableArray	*mutableObservers;

@end

@implementation IDPObservable

#pragma mark -
#pragma mark Class Methods

+ (instancetype)observable {
	return [[[self alloc] init] autorelease];
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
	self.mutableObservers = nil;
	for (id<IDPObserver> observer in self.mutableObservers) {
		[observer removeObservable:self];
	}
	
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.mutableObservers = [NSMutableArray array];
    }
    return self;
}

#pragma mark -
#pragma mark IDPObserver

- (void)addObserver:(id<IDPObserver>)observer {
	[self.mutableObservers addObject:observer];
	[observer addObservable:self];
}

- (void)removeObserver:(id<IDPObserver>)observer {
	[self.mutableObservers removeObjectIdenticalTo:observer];
	[observer removeObservable:self];
}

- (void)notifyObserversWithObservable:(id<IDPObservable>)observable {
	for (id<IDPObserver> observer in self.mutableObservers) {
		[observer didReceiveNotificationFromObservable:observable];
	}
}

- (NSArray *)observers {
	return [[self.mutableObservers copy] autorelease];
}

@end
