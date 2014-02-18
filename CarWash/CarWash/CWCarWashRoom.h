#import "CWRoom.h"

#import "CWJobAcceptance.h"

@class CWCar;

@interface CWCarWashRoom : CWRoom <CWJobAcceptance>
@property (nonatomic, readonly)	NSArray		*cars;

- (void)washCar:(CWCar *)car;

@end
