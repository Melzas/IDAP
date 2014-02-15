#import <Foundation/Foundation.h>

typedef enum {kCWDirty, kCWClean} CWCleanness;

@interface CWCar : NSObject
@property (nonatomic, assign)	CWCleanness	cleanness;
@property (nonatomic, assign)	NSUInteger	money;

+ (instancetype)car;

@end
