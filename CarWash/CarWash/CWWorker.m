#import "CWWorker.h"

#import "IDPObservableWrapper.h"

@interface CWWorker ()
@property (nonatomic, copy, readwrite)		NSString		*name;
@property (nonatomic, assign, readwrite)	NSUInteger		salary;
@property (nonatomic, assign, readwrite)	NSUInteger		yearsOfExperience;
@property (nonatomic, retain)				NSMutableArray	*mutableObservers;
@property (nonatomic, retain)				NSMutableArray	*mutableObservables;

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
	self.mutableObservers = nil;
	
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
		self.mutableObservers = [NSMutableArray array];
	}
	return self;
}

#pragma mark -
#pragma mark Accessors

- (NSArray *)observers {
	return [[self.mutableObservers copy] autorelease];
}

- (NSArray *)observables {
	return [[self.mutableObservables copy] autorelease];
}

#pragma mark -
#pragma mark IDPObservable

- (void)addObserver:(id<CWJobAcceptance>)jobAccepter {
	[self.mutableObservers addObject:jobAccepter];
	[jobAccepter addObservable:self];
}

- (void)removeObserver:(id<CWJobAcceptance>)jobAcceptor {
	[self.mutableObservers removeObjectIdenticalTo:jobAcceptor];
	[jobAcceptor removeObservable:self];
}

- (void)notify {
	for (id<CWJobAcceptance> jobAccepter in self.mutableObservers) {
		[jobAccepter jobCompletedByWorker:self];
	}
}

#pragma mark -
#pragma mark IDPObserver

- (void)addObservable:(id<IDPObservable>)observable {
	IDPObservableWrapper *observableWrapper = [[[IDPObservableWrapper alloc] init] autorelease];
	observableWrapper.observable = observable;
	[self.mutableObservables addObject:observableWrapper];
}

- (void)removeObservable:(id<IDPObservable>)observable {
	NSMutableIndexSet *indexSet = [NSMutableIndexSet indexSet];
	for (NSUInteger i = 0; i < [self.mutableObservables count]; ++i) {
		if (observable == self.mutableObservables[i]) {
			[indexSet addIndex:i];
		}
	}
	[self.mutableObservables removeObjectsAtIndexes:indexSet];
}

#pragma mark -
#pragma mark CWJobAcceptance

- (void)jobCompletedByWorker:(CWWorker *)worker {
	
}

@end
