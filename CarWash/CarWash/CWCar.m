#import "CWCar.h"

#import "CWWorker.h"

static const NSUInteger kCWCarWashPrice = 200;
static const NSUInteger kCWCarMinMoney = 200;
static const NSUInteger kCWCarMaxMoney = 500;

@interface CWCar ()
@property (nonatomic, copy, readwrite)	NSString	*name;

@end

@implementation CWCar

#pragma mark -
#pragma mark Class Methods

+ (instancetype)carWithName:(NSString *)name {
	return [[[self alloc] initWithName:name] autorelease];
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
	self.name = nil;
	
	[super dealloc];
}

- (instancetype)init {
	return [self initWithName:nil];
}

- (instancetype)initWithName:(NSString *)name {
	if (self = [super init]) {
		self.name = name;
		self.money = kCWCarMinMoney + arc4random_uniform(kCWCarMaxMoney - kCWCarMinMoney + 1);
	}
	return self;
}

#pragma mark -
#pragma mark CWJobAcceptance

- (void)jobCompletedByWorker:(CWWorker *)worker {
	NSLog(@"%@ is clean, give %lu dollars to %@", self.name, kCWCarWashPrice, worker.name);
	self.money -= kCWCarWashPrice;
	worker.money += kCWCarWashPrice;
}

@end
