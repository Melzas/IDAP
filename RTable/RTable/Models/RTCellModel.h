#import <Foundation/Foundation.h>

@interface RTCellModel : NSObject <NSCoding>
@property (nonatomic, copy)	NSString	*string;

// returns model with random string
+ (instancetype)model;

@end
