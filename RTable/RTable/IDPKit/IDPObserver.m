#import "IDPObserver.h"

#import "IDPWeakReference.h"

@interface IDPObserver ()
@property (nonatomic, retain)	NSMutableArray	*mutableObservableObjects;

@end

@implementation IDPObserver

#pragma mark -
#pragma mark Class Methods

+ (instancetype)observer {
	return [[[self alloc] init] autorelease];
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
	self.mutableObservableObjects = nil;
	
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.mutableObservableObjects = [NSMutableArray array];
    }
    return self;
}

#pragma mark -
#pragma mark IDPObserver

- (void)addObservableObject:(id<IDPObservableObject>)observableObject {
	IDPWeakReference *weakObservableObject = [IDPWeakReference referenceWithObject:observableObject];
	
	[self.mutableObservableObjects addObject:weakObservableObject];
}

- (void)removeObservableObject:(id<IDPObservableObject>)observableObject {
	NSMutableIndexSet *indexSet = [NSMutableIndexSet indexSet];
	
	for (NSUInteger i = 0; i < [self.mutableObservableObjects count]; ++i) {
		IDPWeakReference *weakObservableObjectReference = self.mutableObservableObjects[i];
		if (observableObject == weakObservableObjectReference.object) {
			[indexSet addIndex:i];
		}
	}
	
	[self.mutableObservableObjects removeObjectsAtIndexes:indexSet];
}

- (void)didReceiveNotificationFromObservableObject:(id<IDPObservableObject>)observableObject {
	
}

- (NSArray *)observables {
	return [[self.mutableObservableObjects copy] autorelease];
}

@end
