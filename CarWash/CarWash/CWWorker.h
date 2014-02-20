#import <Foundation/Foundation.h>

#import "IDPObservable.h"
#import "IDPServiceQueue.h"
#import "CWJobAcceptance.h"

@interface CWWorker : IDPServiceQueue <CWJobAcceptance, IDPObservable>
@property (nonatomic, readonly)		NSString	*name;
@property (nonatomic, readonly)		NSUInteger	salary;
@property (nonatomic, readonly)		NSUInteger	yearsOfExperience;
@property (atomic, assign)			NSUInteger	money;

+ (instancetype)workerWithName:(NSString *)name
						salary:(NSUInteger)salary
			 yearsOfExperience:(NSUInteger)yearsOfExperience;

- (instancetype)initWithName:(NSString *)name
					  salary:(NSUInteger)salary
		   yearsOfExperience:(NSUInteger)yearsOfExperience;

@end
