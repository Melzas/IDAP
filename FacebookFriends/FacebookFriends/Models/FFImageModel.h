#import "IDPModel.h"

@class FFImageCache;

@interface FFImageModel : IDPModel <NSCoding>
@property (nonatomic, readonly)	UIImage		*image;
@property (nonatomic, readonly)	NSString	*path;

@property (nonatomic, assign)	FFImageCache	*cache;

+ (id)modelWithPath:(NSString *)path;
- (id)initWithPath:(NSString *)path;

@end
