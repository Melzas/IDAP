#import "IDPModel.h"

@interface FFImageModel : IDPModel <NSCoding>
@property (nonatomic, readonly)	UIImage		*image;
@property (nonatomic, readonly)	NSString	*path;

+ (id)modelWithPath:(NSString *)path;
- (id)initWithPath:(NSString *)path;

@end
