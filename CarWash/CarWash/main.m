#import <Foundation/Foundation.h>

#import "CWBuilding.h"
#import "CWCarWashRoom.h"

#import "CWCarWasher.h"
#import "CWBooker.h"
#import "CWDirector.h"

int main(int argc, const char * argv[]) {
	@autoreleasepool {
	    CWBuilding *carWashBuilding = [CWBuilding building];
		
		CWCarWashRoom *firstCarWashRoom = [CWCarWashRoom roomWithWorkerCapacity:2 carCapacity:2];
		CWCarWasher *carWasherSam = [CWCarWasher workerWithName:@"Sam"
														   salary:500
												yearsOfExperience:2];
		CWCarWasher *carWasherAnn = [CWCarWasher workerWithName:@"Ann"
															salary:400
												 yearsOfExperience:1];
		[firstCarWashRoom addWorker:carWasherSam];
		[firstCarWashRoom addWorker:carWasherAnn];
		[carWashBuilding addRoom:firstCarWashRoom];
		
		CWCarWashRoom *secondCarWashRoom = [CWCarWashRoom roomWithWorkerCapacity:1 carCapacity:1];
		CWCarWasher *carWasherAndy = [CWCarWasher workerWithName:@"Andy"
														  salary:1000
											   yearsOfExperience:15];
		[secondCarWashRoom addWorker:carWasherAndy];
		[carWashBuilding addRoom:secondCarWashRoom];
		
		CWBuilding *adminBuilding = [CWBuilding building];
		
		CWRoom *bookerRoom = [CWRoom roomWithWorkerCapacity:2];
		CWBooker *bookerMatt = [CWBooker workerWithName:@"Matt" salary:800 yearsOfExperience:4];
		CWBooker *bookerJane = [CWBooker workerWithName:@"Jane" salary:200 yearsOfExperience:0];
		[bookerRoom addWorker:bookerMatt];
		[bookerRoom addWorker:bookerJane];
		
		CWRoom *directorRoom = [CWRoom roomWithWorkerCapacity:1];
		CWDirector *directorAlex = [CWDirector workerWithName:@"Alex"
													   salary:2000
											yearsOfExperience:11];
		[directorRoom addWorker:directorAlex];
		
		[adminBuilding addRoom:bookerRoom];
		[adminBuilding addRoom:directorRoom];
	}
    return 0;
}

