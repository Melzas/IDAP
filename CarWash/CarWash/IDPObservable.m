#import "IDPObservable.h"

#import "IDPObserverProtocol.h"

@interface IDPObservable ()
@property (nonatomic, retain)	NSMutableArray	*mutableObservers;

@end

@implementation IDPObservable

- (void)addObserver:(id<IDPObserver>)observer {
	[self.mutableObservers addObject:observer];
	[observer addObservable:self];
}

- (void)removeObserver:(id<IDPObserver>)observer {
	[self.mutableObservers removeObjectIdenticalTo:observer];
	[observer removeObservable:self];
}

- (void)notifyObservers {
	for (id<IDPObserver> observer in self.mutableObservers) {
		[observer notify];
	}
}

- (NSArray *)observers {
	return [[self.mutableObservers copy] autorelease];
}

@end
