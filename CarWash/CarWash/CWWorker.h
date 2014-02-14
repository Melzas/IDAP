#import <Foundation/Foundation.h>

@interface CWWorker : NSObject
@property (nonatomic, readonly)	NSString	*name;
@property (nonatomic, readonly)	NSUInteger	salary;
@property (nonatomic, readonly)	NSUInteger	yearsOfExperience;
@property (nonatomic, assign)	NSUInteger	currentMoney;

+ (instancetype)workerWithName:(NSString *)name
						salary:(NSUInteger)salary
			 yearsOfExperience:(NSUInteger)yearsOfExperience;

- (instancetype)initWithName:(NSString *)name
					  salary:(NSUInteger)salary
		   yearsOfExperience:(NSUInteger)yearsOfExperience;

@end
