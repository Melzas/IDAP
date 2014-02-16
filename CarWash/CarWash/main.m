#import <Foundation/Foundation.h>

#import "CWBuilding.h"
#import "CWCarWashRoom.h"

#import "CWCarWasher.h"
#import "CWBooker.h"
#import "CWDirector.h"

#import "CWCar.h"

int main(int argc, const char * argv[]) {
	@autoreleasepool {
		CWBuilding *adminBuilding = [CWBuilding building];
				
		CWRoom *directorRoom = [CWRoom roomWithWorkerCapacity:1];
		CWDirector *directorAlex = [CWDirector workerWithName:@"Alex"
													   salary:2000
											yearsOfExperience:11];
		[directorRoom addWorker:directorAlex];
		
		CWRoom *bookerRoom = [CWRoom roomWithWorkerCapacity:2];
		CWBooker *bookerMatt = [CWBooker workerWithName:@"Matt" salary:800 yearsOfExperience:4];
		bookerMatt.moneyCollector = directorAlex;
		CWBooker *bookerJane = [CWBooker workerWithName:@"Jane" salary:200 yearsOfExperience:0];
		bookerJane.moneyCollector = directorAlex;
		[bookerRoom addWorker:bookerMatt];
		[bookerRoom addWorker:bookerJane];
		
		
	    CWBuilding *carWashBuilding = [CWBuilding building];
		
		CWCarWashRoom *firstCarWashRoom = [CWCarWashRoom roomWithWorkerCapacity:2 carCapacity:2];
		CWCarWasher *carWasherSam = [CWCarWasher workerWithName:@"Sam"
														   salary:500
												yearsOfExperience:2];
		carWasherSam.moneyCollector = bookerMatt;
		CWCarWasher *carWasherAnn = [CWCarWasher workerWithName:@"Ann"
															salary:400
												 yearsOfExperience:1];
		carWasherAnn.moneyCollector = bookerJane;
		[firstCarWashRoom addWorker:carWasherSam];
		[firstCarWashRoom addWorker:carWasherAnn];
		[carWashBuilding addRoom:firstCarWashRoom];
		
		CWCarWashRoom *secondCarWashRoom = [CWCarWashRoom roomWithWorkerCapacity:1 carCapacity:1];
		CWCarWasher *carWasherAndy = [CWCarWasher workerWithName:@"Andy"
														  salary:1000
											   yearsOfExperience:15];
		carWasherAndy.moneyCollector = bookerJane;
		[secondCarWashRoom addWorker:carWasherAndy];
		[carWashBuilding addRoom:secondCarWashRoom];
		
		[adminBuilding addRoom:bookerRoom];
		[adminBuilding addRoom:directorRoom];
		
		NSUInteger totalCarCount = 0;
		while (totalCarCount <= 100) {
		}
	}
    return 0;
}

