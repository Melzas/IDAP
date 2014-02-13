#import "CWRoom.h"

@interface CWCarWashRoom : CWRoom
@property (nonatomic, readonly)	NSArray		*cars;
@property (nonatomic, readonly)	NSUInteger	carCapacity;

+ (instancetype)roomWithWorkerCapacity:(NSUInteger)workerCapacity
						   carCapacity:(NSUInteger)carCapacity;
- (instancetype)initWithWorkerCapacity:(NSUInteger)workerCapacity
						   carCapacity:(NSUInteger)carCapacity;

- (NSArray *)cars;

- (BOOL)addCar:(id)car;

@end
