#import "IDPModel.h"

@interface IDPImageModel : IDPModel
@property (nonatomic, readonly)	UIImage		*image;
@property (nonatomic, readonly)	NSString	*path;

+ (id)modelWithImageFromFilePath:(NSString *)path;

@end
