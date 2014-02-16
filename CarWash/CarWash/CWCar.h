#import <Foundation/Foundation.h>

#import "CWJobAcceptance.h"

typedef enum {kCWDirty, kCWClean} CWCleanness;

extern const NSUInteger kCWCarWashPrice;

@interface CWCar : NSObject <CWJobAcceptance>
@property (nonatomic, assign)	CWCleanness	cleanness;
@property (nonatomic, assign)	NSUInteger	money;

+ (instancetype)car;

@end
