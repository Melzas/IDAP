#import "CWWorker.h"

@interface CWWorker ()
@property (nonatomic, copy, readwrite)		NSString		*name;
@property (nonatomic, assign, readwrite)	NSUInteger		salary;
@property (nonatomic, assign, readwrite)	NSUInteger		yearsOfExperience;
@property (nonatomic, retain)				NSMutableArray	*mutableJobAccepters;

@end

@implementation CWWorker

@dynamic jobAccepters;

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
	self.mutableJobAccepters = nil;
	
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
		self.mutableJobAccepters = [NSMutableArray array];
	}
	return self;
}

#pragma mark -
#pragma mark Accessors

- (NSArray *)jobAccepters {
	return [[self.mutableJobAccepters copy] autorelease];
}

#pragma mark -
#pragma mark Public

- (void)addJobAccepter:(id<CWJobAcceptance>)jobAccepter {
	[self.mutableJobAccepters addObject:jobAccepter];
}

- (void)removeJobAccepter:(id<CWJobAcceptance>)jobAcceptor {
	[self.mutableJobAccepters removeObjectIdenticalTo:jobAcceptor];
}

- (void)notify {
	for (id<CWJobAcceptance> jobAccepter in self.mutableJobAccepters) {
		[jobAccepter jobCompletedByWorker:self];
	}
}

#pragma mark -
#pragma mark CWJobAcceptance

- (void)jobCompletedByWorker:(CWWorker *)worker {
	
}

@end
