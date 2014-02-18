#import <Foundation/Foundation.h>

#import "CWJobAcceptance.h"

@interface CWWorker : NSObject <CWJobAcceptance>
@property (nonatomic, readonly)		NSString	*name;
@property (nonatomic, readonly)		NSUInteger	salary;
@property (nonatomic, readonly)		NSUInteger	yearsOfExperience;
@property (nonatomic, assign)		NSUInteger	money;

@property (nonatomic, readonly)		NSArray		*jobAccepters;
@property (nonatomic, readonly)		NSArray		*serviceQueue;

@property (atomic, assign, getter = isBusy)	BOOL	busy;

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
