#import "IDPObservableObject.h"

#import "IDPObserverProtocol.h"

#import "NSObject+IDPExtensions.h"

@interface IDPObservableObject ()
@property (nonatomic, retain)	NSMutableArray	*mutableObservers;

@end

@implementation IDPObservableObject

#pragma mark -
#pragma mark Class Methods

+ (instancetype)observableObject {
	return [self object];
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
	self.mutableObservers = nil;
	for (id<IDPObserver> observer in self.mutableObservers) {
		if ([observer respondsToSelector:@selector(removeObservableObject:)]) {
			[observer removeObservableObject:self];
		}
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
	
	if ([observer respondsToSelector:@selector(addObservableObject:)]) {
		[observer addObservableObject:self];
	}
}

- (void)removeObserver:(id<IDPObserver>)observer {
	[self.mutableObservers removeObjectIdenticalTo:observer];
	
	if ([observer respondsToSelector:@selector(removeObservableObject:)]) {
		[observer removeObservableObject:self];
	}
}

- (void)notifyObserversWithObservableObject:(id<IDPObservableObject>)observableObject {
	for (id<IDPObserver> observer in self.mutableObservers) {
		[observer didReceiveNotificationFromObservableObject:observableObject];
	}
}

- (NSArray *)observers {
	return [[self.mutableObservers copy] autorelease];
}

@end
