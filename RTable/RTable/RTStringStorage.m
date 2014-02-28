#import "RTStringStorage.h"

@interface RTStringStorage ()
@property (nonatomic, retain)	NSMutableArray	*mutableStrings;

@end

@implementation RTStringStorage

@dynamic strings;

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
	self.mutableStrings = nil;
	
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.mutableStrings = [NSMutableArray array];
    }
    return self;
}


#pragma mark -
#pragma mark Accessors

- (NSArray *)strings {
	return [[self.mutableStrings copy] autorelease];
}

#pragma mark -
#pragma mark Public

- (void)addString:(NSString *)string {
	[self.mutableStrings addObject:string];
}

- (void)removeString:(NSString *)string {
	[self.mutableStrings removeObject:string];
}

- (void)moveStringFromIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex {
	NSString *stringToMove = [[self.mutableStrings[fromIndex] retain] autorelease];
	[self.mutableStrings removeObject:stringToMove];
	[self.mutableStrings insertObject:stringToMove atIndex:toIndex];
}

@end
