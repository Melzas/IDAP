#import "FFImageCache.h"

#import "NSObject+IDPExtensions.h"

#import "FFImageModel.h"

static FFImageCache *IDPSharedImageCache = nil;

@interface FFImageCache ()
@property (nonatomic, retain)	NSMutableDictionary	*imageCache;

@end

@implementation FFImageCache

#pragma mark -
#pragma mark Class Methods

+ (id)sharedObject {
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		IDPSharedImageCache = [[self alloc] init];
	});
	
	return IDPSharedImageCache;
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

- (void)addImage:(FFImageModel *)imageModel {
	@synchronized(self) {
		[self.imageCache setObject:imageModel forKey:imageModel.path];
	}
}

- (void)removeImage:(FFImageModel *)imageModel {
	@synchronized(self) {
		[self.imageCache removeObjectForKey:imageModel.path];
	}
}

- (FFImageModel *)cachedImageForPath:(NSString *)imagePath {
	FFImageModel *imageModel = nil;
	@synchronized(self) {
		imageModel = [self.imageCache objectForKey:imagePath];
	}
	
	return imageModel;
}

#pragma mark -
#pragma mark Private

+ (id)__sharedObject {
	return IDPSharedImageCache;
}

@end
