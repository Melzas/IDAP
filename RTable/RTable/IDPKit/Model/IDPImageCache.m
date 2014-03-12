#import "IDPImageCache.h"

#import "NSObject+IDPExtensions.h"

#import "IDPImageModel.h"

static IDPImageCache *sharedImageCache = nil;

@interface IDPImageCache ()
@property (nonatomic, retain)	NSCache	*imageCache;

@end

@implementation IDPImageCache

#pragma mark -
#pragma mark Class Methods

+ (id)sharedObject {
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		sharedImageCache = [[self alloc] init];
	});
	
	return sharedImageCache;
}


#pragma mark -
#pragma mark Initializatins and Deallocations

- (void)dealloc {
	self.imageCache = nil;
	
	[super dealloc];
}

- (id)init {
	self = [super init];
	if (self) {
		self.imageCache = [NSCache object];
	}
	
	return  self;
}

#pragma mark -
#pragma mark Public

- (void)addImage:(IDPImageModel *)imageModel {
	[self.imageCache setObject:imageModel.image forKey:imageModel.path];
}

- (void)removeImage:(IDPImageModel *)imageModel {
	[self.imageCache removeObjectForKey:imageModel.path];
}

- (UIImage *)cachedImageForPath:(NSString *)imagePath {
	return [self.imageCache objectForKey:imagePath];
}

#pragma mark -
#pragma mark Private

+ (id)__sharedObject {
	return sharedImageCache;
}

@end
