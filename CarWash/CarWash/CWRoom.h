#import <Foundation/Foundation.h>

@class CWWorker;

@interface CWRoom : NSObject
@property (nonatomic, readonly)	NSArray		*workers;
@property (nonatomic, readonly)	NSUInteger	workerCapacity;

+ (instancetype)roomWithWorkerCapacity:(NSUInteger)workerCapacity;
- (instancetype)initWithWorkerCapacity:(NSUInteger)workerCapacity;

- (BOOL)addWorker:(CWWorker *)worker;
- (BOOL)removeWorker:(CWWorker *)worker;
- (CWWorker *)freeWorker;
- (CWWorker *)randomWorker;

@end
