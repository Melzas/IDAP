#import <Foundation/Foundation.h>

#import "CWCarWash.h"
#import "CWCarQueue.h"

int main(int argc, const char * argv[]) {
	@autoreleasepool {
		CWCarWash *carWash = [CWCarWash carWash];
		CWCarQueue *carQueue = [CWCarQueue carQueueWithCarWashBuilding:carWash.carWashBuilding
															  carCount:10];
		[carQueue start];
	
		NSRunLoop *loop = [NSRunLoop currentRunLoop];
		[loop run];
	}
    return 0;
}

