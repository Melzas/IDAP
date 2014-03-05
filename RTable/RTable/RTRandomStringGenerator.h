#import <Foundation/Foundation.h>

@interface RTRandomStringGenerator : NSObject
@property (nonatomic, assign)	NSUInteger	stringLength;

+ (instancetype)generatorWithStringLength:(NSUInteger)stringLength;
- (instancetype)initWithStringLength:(NSUInteger)stringLength;

- (NSString *)generateRandomString;

@end
