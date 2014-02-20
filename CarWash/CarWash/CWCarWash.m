#import "CWCarWash.h"

#import "CWCarWashBuilding.h"
#import "CWCarWashRoom.h"

#import "CWCarWasher.h"
#import "CWBooker.h"
#import "CWDirector.h"

@interface CWCarWash ()
@property (nonatomic, retain, readwrite)	CWBuilding			*adminBuilding;
@property (nonatomic, retain, readwrite)	CWCarWashBuilding	*carWashBuilding;

- (void)createBuildings;

@end

@implementation CWCarWash

#pragma mark -
#pragma mark Class methods

+ (instancetype)carWash {
	return [[[self alloc] init] autorelease];
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
	self.adminBuilding = nil;
	self.carWashBuilding = nil;
	
	[super dealloc];
}

- (id)init {
	if (self = [super init]) {
		[self createBuildings];
	}
	return self;
}

#pragma mark -
#pragma mark Private

- (void)createBuildings {
	self.adminBuilding = [CWBuilding building];
	
	CWRoom *directorRoom = [CWRoom roomWithWorkerCapacity:1];
	CWDirector *directorAlex = [CWDirector workerWithName:@"Alex"
												   salary:2000
										yearsOfExperience:11];
	[directorRoom addWorker:directorAlex];
	
	CWRoom *bookerRoom = [CWRoom roomWithWorkerCapacity:2];
	CWBooker *bookerMatt = [CWBooker workerWithName:@"Matt" salary:800 yearsOfExperience:4];
	[bookerMatt addJobAccepter:directorAlex];
	CWBooker *bookerJane = [CWBooker workerWithName:@"Jane" salary:200 yearsOfExperience:0];
	[bookerJane addJobAccepter:directorAlex];
	[bookerRoom addWorker:bookerMatt];
	[bookerRoom addWorker:bookerJane];
	
	[self.adminBuilding addRoom:bookerRoom];
	[self.adminBuilding addRoom:directorRoom];
	
	self.carWashBuilding = [CWCarWashBuilding building];
	
	CWCarWashRoom *firstCarWashRoom = [CWCarWashRoom roomWithWorkerCapacity:2];
	CWCarWasher *carWasherSam = [CWCarWasher workerWithName:@"Sam"
													 salary:500
										  yearsOfExperience:2];
	[carWasherSam addJobAccepter:bookerMatt];
	
	CWCarWasher *carWasherAnn = [CWCarWasher workerWithName:@"Ann"
													 salary:400
										  yearsOfExperience:1];
	[carWasherAnn addJobAccepter:bookerJane];
	
	[firstCarWashRoom addWorker:carWasherSam];
	[firstCarWashRoom addWorker:carWasherAnn];
	
	CWCarWashRoom *secondCarWashRoom = [CWCarWashRoom roomWithWorkerCapacity:1];
	CWCarWasher *carWasherAndy = [CWCarWasher workerWithName:@"Andy"
													  salary:1000
										   yearsOfExperience:15];
	[carWasherAndy addJobAccepter:bookerJane];
	
	[secondCarWashRoom addWorker:carWasherAndy];
	
	[self.carWashBuilding addRoom:firstCarWashRoom];
	[self.carWashBuilding addRoom:secondCarWashRoom];

}

@end
