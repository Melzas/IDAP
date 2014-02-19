#import <Foundation/Foundation.h>

#import "CWJobAcceptance.h"
#import "IDPServiceQueue.h"

@interface CWWorker : IDPServiceQueue <CWJobAcceptance>
@property (nonatomic, readonly)		NSString	*name;
@property (nonatomic, readonly)		NSUInteger	salary;
@property (nonatomic, readonly)		NSUInteger	yearsOfExperience;
@property (atomic, assign)			NSUInteger	money;
@property (nonatomic, readonly)		NSArray		*jobAccepters;

+ (instancetype)workerWithName:(NSString *)name
						salary:(NSUInteger)salary
			 yearsOfExperience:(NSUInteger)yearsOfExperience;

- (instancetype)initWithName:(NSString *)name
					  salary:(NSUInteger)salary
		   yearsOfExperience:(NSUInteger)yearsOfExperience;

- (void)addJobAccepter:(id<CWJobAcceptance>)jobAccepter;
- (void)removeJobAccepter:(id<CWJobAcceptance>)jobAcceptor;
- (void)notify;

@end
