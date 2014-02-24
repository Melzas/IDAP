#import "IDPObserver.h"

#import "IDPObservableWrapper.h"
#import "NSObject+IDPExtensions.h"

@interface IDPObserver ()
@property (nonatomic, retain)	NSMutableArray	*mutableObservables;

@end

@implementation IDPObserver

#pragma mark -
#pragma mark Class Methods

+ (instancetype)observer {
	return [self object];
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
	self.mutableObservables = nil;
	
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.mutableObservables = [NSMutableArray array];
    }
    return self;
}

#pragma mark -
#pragma mark IDPObserver

- (void)addObservable:(id<IDPObservable>)observable {
	IDPObservableWrapper *wrapper = [IDPObservableWrapper wrapperWithObservable:observable];
	[self.mutableObservables addObject:wrapper];
}

- (void)removeObservable:(id<IDPObservable>)observable {
	NSMutableIndexSet *indexSet = [NSMutableIndexSet indexSet];
	for (NSUInteger i = 0; i < [self.mutableObservables count]; ++i) {
		IDPObservableWrapper *wrapper = self.mutableObservables[i];
		if (observable == wrapper.observable) {
			[indexSet addIndex:i];
		}
	}
	[self.mutableObservables removeObjectsAtIndexes:indexSet];
}

- (void)didReceiveNotificationFromObservable:(id<IDPObservable>)observable {
	
}

- (NSArray *)observables {
	return [[self.mutableObservables copy] autorelease];
}

@end
