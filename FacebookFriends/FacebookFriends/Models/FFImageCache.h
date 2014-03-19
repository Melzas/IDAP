#import <Foundation/Foundation.h>

#import "IDPSingletonModel.h"

@class FFImageModel;

@interface FFImageCache : IDPSingletonModel

- (void)addImage:(FFImageModel *)imageModel;
- (void)removeImage:(FFImageModel *)imageModel;

// returns nil if image not in the cache
- (FFImageModel *)cachedImageForPath:(NSString *)imagePath;

@end
