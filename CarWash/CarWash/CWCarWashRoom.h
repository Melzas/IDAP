#import "CWRoom.h"

@class CWCar;

@interface CWCarWashRoom : CWRoom
@property (nonatomic, readonly)	NSArray		*cars;
@property (nonatomic, readonly)	NSUInteger	carCapacity;

+ (instancetype)roomWithWorkerCapacity:(NSUInteger)workerCapacity
						   carCapacity:(NSUInteger)carCapacity;
- (instancetype)initWithWorkerCapacity:(NSUInteger)workerCapacity
						   carCapacity:(NSUInteger)carCapacity;

- (BOOL)addCar:(CWCar *)car;
- (void)washAllCars;

@end
