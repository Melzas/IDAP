#import "CWCarQueue.h"

#import "CWCar.h"
#import "CWCarWashBuilding.h"

@interface CWCarQueue ()
@property (nonatomic, retain, readwrite)	CWCarWashBuilding	*carWashBuilding;
@property (nonatomic, assign, readwrite)	NSUInteger			carCount;
@property (nonatomic, assign, readwrite)	dispatch_queue_t	dispatchQueue;

@end

@implementation CWCarQueue

+ (instancetype)carQueueWithCarWashBuilding:(CWCarWashBuilding *)carWashBuilding
								   carCount:(NSUInteger)carCount
{
	return [[[self alloc] initWithCarWashBuilding:carWashBuilding carCount:carCount] autorelease];
}

- (void)dealloc {
	self.carWashBuilding = nil;
	dispatch_release(self.dispatchQueue);
	
	[super dealloc];
}

- (instancetype)initWithCarWashBuilding:(CWCarWashBuilding *)carWashBuilding
							   carCount:(NSUInteger)carCount
{
	if (self = [super init]) {
		self.carWashBuilding = carWashBuilding;
		self.carCount = carCount;
		self.dispatchQueue = dispatch_queue_create("carQueue", DISPATCH_QUEUE_SERIAL);
	}
	return self;
}
- (void)start {
	NSUInteger totalCarCount = 0;
	while (totalCarCount < self.carCount) {
		NSUInteger carCountInWave = 1 + arc4random_uniform(5);
		if (totalCarCount + carCountInWave > self.carCount) {
			carCountInWave = self.carCount - totalCarCount;
		}
		dispatch_async(self.dispatchQueue, ^{
			sleep(arc4random_uniform(5));
			for (NSUInteger i = 0; i < carCountInWave; ++i) {
				NSString *carName = [NSString stringWithFormat:@"Car %lu", i + totalCarCount];
				CWCar *car = [CWCar carWithName:carName];
				[self.carWashBuilding addCar:car];
			}
		});
		totalCarCount += carCountInWave;
	}
	
}

@end
