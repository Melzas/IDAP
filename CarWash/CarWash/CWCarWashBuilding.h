#import <Foundation/Foundation.h>

#import "CWBuilding.h"

@class CWCar;

@interface CWCarWashBuilding : CWBuilding
@property (nonatomic, readonly)	NSArray	*carWashRooms;

- (BOOL)addCar:(CWCar *)car;
- (BOOL)removeCar:(CWCar *)car;

- (void)washAllCars;

@end
