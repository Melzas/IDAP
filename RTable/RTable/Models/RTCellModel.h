#import <Foundation/Foundation.h>

#import "IDPModel.h"

@interface RTCellModel : IDPModel <NSCoding>
@property (nonatomic, copy)	NSString	*string;
@property (nonatomic, copy) UIImage		*image;

// returns model with random string
+ (instancetype)model;

@end
