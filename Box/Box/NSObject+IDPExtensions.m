#import "NSObject+IDPExtensions.h"

@implementation NSObject (IDPExtensions)

+ (id)object {
    return [[[self alloc] init] autorelease];
}

@end
