#import "RTStringStorage.h"

@interface RTStringStorage ()
@property (nonatomic, retain)	NSMutableArray	*mutableStrings;

@end

@implementation RTStringStorage

@dynamic strings;

#pragma mark -
#pragma mark Initializations and Deallocations



#pragma mark -
#pragma mark Accessors

- (NSArray *)strings {
	return [[self.mutableStrings copy] autorelease];
}

@end
