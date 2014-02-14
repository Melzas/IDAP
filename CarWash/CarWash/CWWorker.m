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
			 yearsOfExperiance:(NSUInteger)yearsOfExperience
{
	id worker = [[self alloc] initWithName:name salary:salary yearsOfExperiance:yearsOfExperience];
	return [worker autorelease];
}

#pragma mark -
#pragma Initializations and Deallocations

- (void)dealloc {
	self.name = nil;
	
	[super dealloc];
}

- (instancetype)initWithName:(NSString *)name
					  salary:(NSUInteger)salary
		   yearsOfExperiance:(NSUInteger)yearsOfExperience
{
	if(self = [super init]) {
		self.name = name;
		self.salary = salary;
		self.yearsOfExperience = yearsOfExperience;
	}
	return self;
}

@end
