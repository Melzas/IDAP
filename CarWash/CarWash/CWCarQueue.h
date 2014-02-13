#import <Foundation/Foundation.h>

@class CWCarWashBuilding;

@interface CWCarQueue : NSObject
@property (nonatomic, readonly)	CWCarWashBuilding	*carWashBuilding;
@property (nonatomic, readonly)	NSUInteger			carCount;
@property (nonatomic, readonly)	dispatch_queue_t	dispatchQueue;

+ (instancetype)carQueueWithCarWashBuilding:(CWCarWashBuilding *)carWashBuilding
								   carCount:(NSUInteger)carCount;

- (instancetype)initWithCarWashBuilding:(CWCarWashBuilding *)carWashBuilding
							   carCount:(NSUInteger)carCount;
- (void)start;

@end
