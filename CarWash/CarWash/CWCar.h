#import <Foundation/Foundation.h>

#import "CWJobAcceptance.h"
#import "IDPQueueable.h"

typedef enum {kCWDirty, kCWClean} CWCleanness;

@interface CWCar : NSObject <CWJobAcceptance, IDPQueueable>
@property (nonatomic, readonly)	NSString	*name;
@property (nonatomic, assign)	CWCleanness	cleanness;
@property (nonatomic, assign)	NSUInteger	money;

@property (atomic, assign, getter = isInQueue)	BOOL	inQueue;

+ (instancetype)carWithName:(NSString *)name;
- (instancetype)initWithName:(NSString *)name;

@end
