
@class FFImageCache;

@interface FFImageModel : IDPModel
@property (nonatomic, readonly)	NSString		*path;
@property (nonatomic, readonly)	UIImage			*image;
@property (nonatomic, assign)	FFImageCache	*cache;

+ (id)modelWithPath:(NSString *)path;
- (id)initWithPath:(NSString *)path;

- (void)save;
- (void)loadFromFile;

@end
