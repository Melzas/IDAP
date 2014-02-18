#import "CWCarWashBuilding.h"

#import "CWCar.h"
#import "CWCarWashRoom.h"

@implementation CWCarWashBuilding

@dynamic carWashRooms;

#pragma mark -
#pragma mark Accessors

-(NSArray *)carWashRooms {
	NSMutableArray *carWashRooms = [NSMutableArray array];
	for (CWRoom *room in self.rooms) {
		if ([room isMemberOfClass:[CWCarWashRoom class]]) {
			[carWashRooms addObject:room];
		}
	}
	return carWashRooms;
}

#pragma mark -
#pragma mark Public

- (BOOL)addCar:(CWCar *)car {
	for (CWCarWashRoom *carWashRoom in self.carWashRooms) {
		BOOL isCarAdded = [carWashRoom addCar:car];
		if (isCarAdded) {
			return YES;
		}
	}
	return NO;
}

- (BOOL)removeCar:(CWCar *)car {
	for (CWCarWashRoom *carWashRoom in self.carWashRooms) {
		BOOL isCarRemoved = [carWashRoom removeCar:car];
		if (isCarRemoved) {
			return YES;
		}
	}
	return NO;
}

- (void)washAllCars {
	for (CWCarWashRoom *carWashRoom in self.carWashRooms) {
		[carWashRoom washAllCars];
	}
}

@end
