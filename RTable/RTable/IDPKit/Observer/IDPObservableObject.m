#import "IDPObservableObject.h"

#import "NSObject+IDPExtensions.h"

#import "IDPWeakReference.h"

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
#pragma mark Accessors

- (NSArray *)observers {
	NSArray *references = [[self.mutableObservers copy] autorelease];
    
    NSMutableArray *observers = [NSMutableArray arrayWithCapacity:[references count]];
    for (IDPWeakReference *reference in references) {
        [observers addObject:reference.object];
    }
    
    return [[observers copy] autorelease];
}

#pragma mark -
#pragma mark IDPObserver

- (void)addObserver:(id)observer {
	NSMutableArray *mutableObservers = self.mutableObservers;
	IDPWeakReference *reference = [IDPWeakReference referenceWithObject:observer];
	if ([mutableObservers containsObject:reference]) {
		return;
	}
	
	[mutableObservers addObject:reference];
}

- (void)removeObserver:(id)observer {
	IDPWeakReference *reference = [IDPWeakReference referenceWithObject:observer];
	[self.mutableObservers removeObject:reference];
}

- (void)notifyObserversOnMainThreadWithSelector:(SEL)selector {
	dispatch_async(dispatch_get_main_queue(), ^{
		for (id observer in self.observers) {
			if ([observer respondsToSelector:selector]) {
				[observer performSelector:selector withObject:self];
			}
		}
	});
}

- (void)notifyObserversOnMainThreadWithSelector:(SEL)selector object:(id)object {
	dispatch_async(dispatch_get_main_queue(), ^{
		for (id observer in self.observers) {
			if ([observer respondsToSelector:selector]) {
				[observer performSelector:selector withObject:self withObject:object];
			}
		}
	});
}

@end
