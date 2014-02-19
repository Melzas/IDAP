#import <Foundation/Foundation.h>

#import "CWJobAcceptance.h"

typedef enum {kCWDirty, kCWClean} CWCleanness;

@interface CWCar : NSObject <CWJobAcceptance>
@property (nonatomic, readonly)	NSString	*name;
@property (nonatomic, assign)	CWCleanness	cleanness;
@property (nonatomic, assign)	NSUInteger	money;

+ (instancetype)carWithName:(NSString *)name;
- (instancetype)initWithName:(NSString *)name;

@end
