#import "CWWorker.h"

@interface CWWorker ()
@property (nonatomic, copy, readwrite)		NSString	*name;
@property (nonatomic, assign, readwrite)	NSUInteger	salary;
@property (nonatomic, assign, readwrite)	NSUInteger	yearsOfExperience;

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
	self.moneyCollector = nil;
	
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
	}
	return self;
}

#pragma mark -
#pragma mark CWJobAcceptance

- (void)jobCompletedByWorker:(CWWorker *)worker {
	
}

@end
