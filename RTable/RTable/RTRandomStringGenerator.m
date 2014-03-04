#import "RTRandomStringGenerator.h"

static NSString * const letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";

@implementation RTRandomStringGenerator

#pragma mark -
#pragma mark Class Methods

+ (instancetype)generatorWithStringLength:(NSUInteger)stringLength {
	return [[[self alloc] initWithStringLength:stringLength] autorelease];
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)initWithStringLength:(NSUInteger)stringLength {
    self = [super init];
    if (self) {
        self.stringLength = stringLength;
    }
	
    return self;
}

- (instancetype)init {
	return [self initWithStringLength:1];
}

#pragma mark -
#pragma mark Public

- (NSString *)generateRandomString {
	NSMutableString *randomString = [NSMutableString stringWithCapacity:self.stringLength];
	for (int i = 0; i < self.stringLength; ++i) {
		unichar randomLetter = [letters characterAtIndex: arc4random_uniform([letters length])];
		[randomString appendFormat: @"%C", randomLetter];
	}
	return randomString;
}

@end
