#import <Foundation/Foundation.h>

@interface RTStringStorage : NSObject <NSCoding>
@property (nonatomic, readonly)	NSArray	*strings;

- (void)addString:(NSString *)string;
- (void)removeString:(NSString *)string;
- (void)moveStringFromIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex;

@end
