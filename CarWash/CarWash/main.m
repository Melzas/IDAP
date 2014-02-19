#import <Foundation/Foundation.h>

#import "CWCarWashBuilding.h"
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
		[bookerMatt addJobAccepter:directorAlex];
		CWBooker *bookerJane = [CWBooker workerWithName:@"Jane" salary:200 yearsOfExperience:0];
		[bookerJane addJobAccepter:directorAlex];
		[bookerRoom addWorker:bookerMatt];
		[bookerRoom addWorker:bookerJane];
		
		
	    CWCarWashBuilding *carWashBuilding = [CWCarWashBuilding building];
		
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
		[carWashBuilding addRoom:firstCarWashRoom];
		
		CWCarWashRoom *secondCarWashRoom = [CWCarWashRoom roomWithWorkerCapacity:1];
		CWCarWasher *carWasherAndy = [CWCarWasher workerWithName:@"Andy"
														  salary:1000
											   yearsOfExperience:15];
		[carWasherAndy addJobAccepter:bookerJane];
		
		[secondCarWashRoom addWorker:carWasherAndy];
		[carWashBuilding addRoom:secondCarWashRoom];
		
		[adminBuilding addRoom:bookerRoom];
		[adminBuilding addRoom:directorRoom];
		
		NSUInteger totalCarCount = 0;
		while (totalCarCount <= 6) {
			sleep(arc4random_uniform(5));
			NSUInteger carCountInWave = 1 + arc4random_uniform(5);
			for (NSUInteger i = 0; i < carCountInWave; ++i) {
				NSString *carName = [NSString stringWithFormat:@"Car %lu", i + totalCarCount];
				CWCar *car = [CWCar carWithName:carName];
				[carWashBuilding addCar:car];
			}
			totalCarCount += carCountInWave;
		}
	
		NSRunLoop *loop = [NSRunLoop currentRunLoop];
		[loop run];
		NSLog(@"Director profit: %lu", directorAlex.money);
	}
	
    return 0;
}

