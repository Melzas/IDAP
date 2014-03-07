#import <Foundation/Foundation.h>

@interface RTCellModel : NSObject
@property (nonatomic, copy)	NSString	*string;

// returns model with random string
+ (instancetype)model;

@end
