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

- (void)addCar:(CWCar *)car {
	NSArray *carWashRooms = self.carWashRooms;
	for (CWCarWashRoom *carWashRoom in carWashRooms) {
		if ([carWashRoom freeWorker]) {
			[carWashRoom addCar:car];
			return;
		}
	}
	NSUInteger randomRoomIndex = arc4random_uniform((u_int32_t)[carWashRooms count]);
	[carWashRooms[randomRoomIndex] addCar:car];
}

@end
