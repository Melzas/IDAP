#import "IDPImageModel.h"

#import "NSObject+IDPExtensions.h"
#import "NSBundle+IDPExtensions.h"

#import "IDPImageCache.h"

@interface IDPImageModel ()
@property (nonatomic, retain)	UIImage		*image;
@property (nonatomic, copy)		NSString	*path;

@end

@implementation IDPImageModel

#pragma mark -
#pragma mark Class Methods

+ (id)modelWithImageFromFilePath:(NSString *)path {
	IDPImageModel *model = [IDPImageModel object];
	model.path = path;
	
	return model;
}

#pragma mark -
#pragma mark Public

- (void)cleanup {
	self.image = nil;
	self.path = nil;
}

- (void)performLoading {
	IDPImageCache *sharedImageCache = [IDPImageCache sharedObject];
	self.image = [sharedImageCache cachedImageForPath:self.path];
	if (nil != self.image) {
		[self finishLoading];
		return;
	}
	
	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
		sleep(1 + arc4random_uniform(8));
		
		NSString *fullImagePath = [[NSBundle mainBundle] fullPathForResource:self.path];
		self.image = [UIImage imageWithContentsOfFile:fullImagePath];
		[sharedImageCache addImage:self];
		
		[self finishLoading];
	});
}

@end
