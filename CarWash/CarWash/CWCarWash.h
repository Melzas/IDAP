#import <Foundation/Foundation.h>

@class CWBuilding;
@class CWCarWashBuilding;

@interface CWCarWash : NSObject
@property (nonatomic, readonly)	CWBuilding			*adminBuilding;
@property (nonatomic, readonly)	CWCarWashBuilding	*carWashBuilding;

+ (instancetype)carWash;

@end
