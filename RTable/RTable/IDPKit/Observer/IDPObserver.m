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
	for (id<IDPObservableObject> observableObject in self.mutableObservableObjects) {
		if ([observableObject respondsToSelector:@selector(removeObserver:)]) {
			[observableObject removeObserver:self];
		}
	}
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
	[self.mutableObservableObjects addObject:observableObject];
}

- (void)removeObservableObject:(id<IDPObservableObject>)observableObject {
	[self.mutableObservableObjects removeObject:observableObject];
}

- (NSArray *)observables {
	return [[self.mutableObservableObjects copy] autorelease];
}

@end
