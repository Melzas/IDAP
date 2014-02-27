#import <Foundation/Foundation.h>

#import "IDPModel.h"

#import "IDPModelObserver.h"

@class IDPImageModel;

@interface RTCellModel : IDPModel <NSCoding>
@property (nonatomic, copy)		NSString		*string;
@property (nonatomic, retain)	IDPImageModel	*imageModel;

// returns model with random string
+ (instancetype)model;

@end
