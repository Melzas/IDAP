#import <Foundation/Foundation.h>

@interface CWRoom : NSObject
@property (nonatomic, readonly)	NSArray		*workers;
@property (nonatomic, readonly)	NSUInteger	workerCapacity;

+ (instancetype)roomWithWorkerCapacity:(NSUInteger)workerCapacity;
- (instancetype)initWithWorkerCapacity:(NSUInteger)workerCapacity;

- (NSArray *)workers;

- (BOOL)addWorker:(id)worker;

@end
