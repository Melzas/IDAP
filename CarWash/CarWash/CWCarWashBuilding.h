#import <Foundation/Foundation.h>

#import "CWBuilding.h"

@class CWCar;

@interface CWCarWashBuilding : CWBuilding
@property (nonatomic, readonly)	NSArray	*carWashRooms;

- (void)addCar:(CWCar *)car;

@end
