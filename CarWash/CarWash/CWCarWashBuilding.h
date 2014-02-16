#import <Foundation/Foundation.h>

#import "CWBuilding.h"

@class CWCar;

@interface CWCarWashBuilding : CWBuilding

- (BOOL)addCar:(CWCar *)car;
- (void)washAllCars;

@end
