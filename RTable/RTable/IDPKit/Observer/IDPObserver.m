#import "IDPObserver.h"

#import "NSObject+IDPExtensions.h"

@interface IDPObserver ()
@property (nonatomic, retain)	NSMutableArray	*mutableObservableObjects;

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
	self.mutableObservableObjects = nil;
	for (id<IDPObservableObject> observer in self.mutableObservableObjects) {
		if ([observer respondsToSelector:@selector(removeObserver:)]) {
			[observer removeObserver:self];
		}
	}
	
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
	[self.mutableObservableObjects addObject:observableObject];
}

- (void)removeObservableObject:(id<IDPObservableObject>)observableObject {
	[self.mutableObservableObjects removeObject:observableObject];
}

- (NSArray *)observables {
	return [[self.mutableObservableObjects copy] autorelease];
}

@end
