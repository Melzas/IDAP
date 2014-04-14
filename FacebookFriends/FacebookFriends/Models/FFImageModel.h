
typedef enum FFImageType : int16_t {
	kFFIcon,
	kFFFull
} FFImageType;

@class FFImageCache;

@interface FFImageModel : NSManagedObject <IDPModel>
@property (nonatomic, readonly)	NSString		*path;
@property (nonatomic, assign)	FFImageType		type;
@property (nonatomic, readonly)	UIImage			*image;
@property (nonatomic, assign)	FFImageCache	*cache;

+ (id)managedObjectWithPath:(NSString *)path;

@end
