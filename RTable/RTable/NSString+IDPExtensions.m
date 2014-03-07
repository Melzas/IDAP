#import "NSString+IDPExtensions.h"

static NSString * const kRTRandomStringCharacterSet =
	@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";

@implementation NSString (IDPExtensions)

+ (NSString *)randomStringOfLength:(NSUInteger)length {
	NSMutableString *randomString = [NSMutableString stringWithCapacity:length];
	NSUInteger characterSetLength = [kRTRandomStringCharacterSet length];
	
	for (int i = 0; i < length; ++i) {
		NSUInteger randomCharacterIndex = arc4random_uniform(characterSetLength);
		unichar randomLetter = [kRTRandomStringCharacterSet characterAtIndex: randomCharacterIndex];
		[randomString appendFormat: @"%C", randomLetter];
	}
	return randomString;
}

@end
