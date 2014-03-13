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
	@synchronized(self) {
		[self.imageCache setObject:imageModel.image forKey:imageModel.path];
	}
}

- (void)removeImage:(IDPImageModel *)imageModel {
	@synchronized(self) {
		[self.imageCache removeObjectForKey:imageModel.path];
	}
}

- (UIImage *)cachedImageForPath:(NSString *)imagePath {
	UIImage *image = nil;
	@synchronized(self) {
		image = [self.imageCache objectForKey:imagePath];
	}
	
	return image;
}

#pragma mark -
#pragma mark Private

+ (id)__sharedObject {
	return sharedImageCache;
}

@end
