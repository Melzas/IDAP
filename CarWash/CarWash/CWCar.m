#import "CWCar.h"

#import "CWWorker.h"
#import "IDPObserver.h"

static const NSUInteger kCWCarWashPrice = 200;
static const NSUInteger kCWCarMinMoney = 200;
static const NSUInteger kCWCarMaxMoney = 500;

@interface CWCar ()
@property (nonatomic, copy, readwrite)	NSString	*name;

@property (nonatomic, retain)	IDPObserver	*observer;

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
	self.observer = nil;
	
	[super dealloc];
}

- (instancetype)init {
	return [self initWithName:nil];
}

- (instancetype)initWithName:(NSString *)name {
	if (self = [super init]) {
		self.name = name;
		self.money = kCWCarMinMoney + arc4random_uniform(kCWCarMaxMoney - kCWCarMinMoney + 1);
		self.observer = [IDPObserver observer];
	}
	return self;
}

#pragma mark -
#pragma mark IDPObserver

- (void)addObservable:(id<IDPObservable>)observable {
	[self.observer addObservable:observable];
}

- (void)removeObservable:(id<IDPObservable>)observable {
	[self.observer removeObservable:observable];
}

- (NSArray *)observables {
	return [self.observer observables];
}

- (void)didReceiveNotificationFromObservable:(id<IDPObservable>)observable {
	[self jobCompletedByWorker:(CWWorker *)observable];
}

#pragma mark -
#pragma mark CWJobAcceptance

- (void)jobCompletedByWorker:(CWWorker *)worker {
	NSLog(@"%@ is clean, give %lu dollars to %@", self.name, kCWCarWashPrice, worker.name);
	self.money -= kCWCarWashPrice;
	worker.money += kCWCarWashPrice;
}

@end
