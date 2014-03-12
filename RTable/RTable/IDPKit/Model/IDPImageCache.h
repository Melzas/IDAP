#import <Foundation/Foundation.h>

#import "IDPSingletonModel.h"

@class IDPImageModel;

@interface IDPImageCache : IDPSingletonModel

- (void)addImage:(IDPImageModel *)imageModel;
- (void)removeImage:(IDPImageModel *)imageModel;

// returns nil if image not in the cache
- (UIImage *)cachedImageForPath:(NSString *)imagePath;

@end
