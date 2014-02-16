#import <Foundation/Foundation.h>

#import "CWJobAcceptance.h"

@interface CWWorker : NSObject <CWJobAcceptance>
@property (nonatomic, readonly)	NSString	*name;
@property (nonatomic, readonly)	NSUInteger	salary;
@property (nonatomic, readonly)	NSUInteger	yearsOfExperience;
@property (nonatomic, assign)	NSUInteger	money;
@property (nonatomic, retain)	CWWorker	*moneyCollector;

+ (instancetype)workerWithName:(NSString *)name
						salary:(NSUInteger)salary
			 yearsOfExperience:(NSUInteger)yearsOfExperience;

- (instancetype)initWithName:(NSString *)name
					  salary:(NSUInteger)salary
		   yearsOfExperience:(NSUInteger)yearsOfExperience;

@end
