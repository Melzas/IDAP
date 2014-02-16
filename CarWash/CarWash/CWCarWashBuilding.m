#import "CWCarWashBuilding.h"

#import "CWCar.h"
#import "CWCarWashRoom.h"

@implementation CWCarWashBuilding

#pragma mark -
#pragma mark Public

- (BOOL)addCar:(CWCar *)car {
	for (CWRoom *room in self.rooms) {
		if ([room isMemberOfClass:[CWCarWashRoom class]]) {
			CWCarWashRoom *carWashRoom = (CWCarWashRoom *)room;
			BOOL isCarAdded = [carWashRoom addCar:car];
			if (isCarAdded) {
				return YES;
			}
		}
	}
	return NO;
}

- (void)washAllCars {
	for (CWRoom *room in self.rooms) {
		if ([room isMemberOfClass:[CWCarWashRoom class]]) {
			CWCarWashRoom *carWashRoom = (CWCarWashRoom *)room;
			[carWashRoom washAllCars];
		}
	}
}

@end
