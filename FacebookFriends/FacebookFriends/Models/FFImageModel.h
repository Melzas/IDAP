#import "IDPModel.h"

@interface FFImageModel : IDPModel
@property (nonatomic, readonly)	UIImage		*image;
@property (nonatomic, readonly)	NSString	*path;

+ (id)modelWithPath:(NSString *)path;
- (id)initWithPath:(NSString *)path;

- (void)save;

@end
