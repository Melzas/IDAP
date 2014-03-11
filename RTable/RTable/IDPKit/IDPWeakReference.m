#import "IDPWeakReference.h"

@interface IDPWeakReference ()
@property (nonatomic, assign, readwrite)	id	object;

@end

@implementation IDPWeakReference

#pragma mark -
#pragma mark Class Methods

+ (instancetype)referenceWithObject:(id)object {
	return [[[self alloc] initWithObject:object] autorelease];
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)initWithObject:(id)object {
	self = [super init];
    if (self) {
        self.object = object;
    }
    return self;
}

@end
