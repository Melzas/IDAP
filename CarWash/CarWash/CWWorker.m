#import "CWWorker.h"

#import "IDPObservable.h"
#import "IDPObserver.h"

static const uint32_t	kCWWorkerMaxDelay = 3;

@interface CWWorker ()
@property (nonatomic, copy, readwrite)		NSString		*name;
@property (nonatomic, assign, readwrite)	NSUInteger		salary;
@property (nonatomic, assign, readwrite)	NSUInteger		yearsOfExperience;

@property (nonatomic, retain)	IDPObservable	*observable;
@property (nonatomic, retain)	IDPObserver		*observer;

@end

@implementation CWWorker

#pragma mark -
#pragma mark Class Methods

+ (instancetype)workerWithName:(NSString *)name
						salary:(NSUInteger)salary
			 yearsOfExperience:(NSUInteger)yearsOfExperience
{
	id worker = [[self alloc] initWithName:name salary:salary yearsOfExperience:yearsOfExperience];
	return [worker autorelease];
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
	self.name = nil;
	self.observable = nil;
	self.observer = nil;
	
	[super dealloc];
}

- (instancetype)initWithName:(NSString *)name
					  salary:(NSUInteger)salary
		   yearsOfExperience:(NSUInteger)yearsOfExperience
{
	if (self = [super init]) {
		self.name = name;
		self.salary = salary;
		self.yearsOfExperience = yearsOfExperience;
		
		self.observable = [IDPObservable observable];
		self.observer = [IDPObserver observer];
	}
	return self;
}

#pragma mark -
#pragma mark Accessors

- (NSArray *)observers {
	return self.observable.observers;
}

- (NSArray *)observables {
	return self.observer.observables;
}

#pragma mark -
#pragma mark IDPObservable

- (void)addObserver:(id<CWJobAcceptance>)jobAccepter {
	[self.observable addObserver:jobAccepter];
}

- (void)removeObserver:(id<CWJobAcceptance>)jobAccepter {
	[self.observable removeObserver:jobAccepter];
}

- (void)notifyObserversWithObservable:(id<IDPObservable>)observable {
	[self.observable notifyObserversWithObservable:observable];
}

#pragma mark -
#pragma mark IDPObserver

- (void)addObservable:(id<IDPObservable>)observable {
	[self.observer addObservable:observable];
}

- (void)removeObservable:(id<IDPObservable>)observable {
	[self.observer removeObservable:observable];
}

- (void)didReceiveNotificationFromObservable:(id<IDPObservable>)observable {
	
}

#pragma mark -
#pragma mark CWJobAcceptance

- (void)jobCompletedByWorker:(CWWorker *)worker {
	
}

@end
