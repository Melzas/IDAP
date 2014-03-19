#import "FFImageModel.h"

#import "NSObject+IDPExtensions.h"
#import "NSBundle+IDPExtensions.h"

#import "FFImageCache.h"

static NSString * const kFFImagePathKey = @"kFFImagePathKey";

@interface FFImageModel ()
@property (nonatomic, retain)	UIImage		*image;
@property (nonatomic, copy)		NSString	*path;

@property (nonatomic, readonly)	NSString	*cachePath;

- (void)loadFromFile;
- (void)loadFromURL;

@end

@implementation FFImageModel

@dynamic cachePath;

#pragma mark -
#pragma mark Class Methods

+ (id)modelWithPath:(NSString *)path {
	return [[[self alloc] initWithPath:path] autorelease];
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)cleanup {
	[self save];
	
	self.image = nil;
	self.path = nil;
}

- (id)initWithPath:(NSString *)path {
	FFImageCache *sharedImageCache = [FFImageCache sharedObject];
	FFImageModel *imageModel = [sharedImageCache cachedImageForPath:path];
	
	if (nil != imageModel) {
		[self autorelease];
		return [imageModel retain];
	}
	
    self = [super init];
    if (self) {
		self.path = path;
		[sharedImageCache addImage:self];
    }
	
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSString *)cachePath {
	NSString *fileName = [[self.path componentsSeparatedByString:@"/"] lastObject];
	NSString *libraryDirectoryPath = [NSFileManager libraryDirectoryPath];
	NSString *cacheDirectoryPath = [libraryDirectoryPath stringByAppendingPathComponent:@"Caches"];
	return [cacheDirectoryPath stringByAppendingPathComponent:fileName];
}

#pragma mark -
#pragma mark Public

- (void)save {
	[self.image writeToFile:self.cachePath atomically:YES inFormat:IDPJPEGImageFile];
}

#pragma mark -
#pragma mark Private

- (void)performLoading {
	if (nil != self.image) {
		[self finishLoading];
		return;
	}
	
	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
		IDPNetworkReachability *networkReachability = [IDPNetworkReachability reachability];
		networkReachability.isReachable ? [self loadFromURL] : [self loadFromFile];
		
		self.image ? [self finishLoading] : [self failLoading];
	});
}

- (void)loadFromFile {
	self.image = [UIImage imageWithContentsOfFile:self.cachePath];
}

- (void)loadFromURL {
	NSURL *imageUrl = [NSURL URLWithString:self.path];
	self.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageUrl]];
}

#pragma mark -
#pragma mark NSCoding

- (id)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if (self) {
		self.path = [decoder decodeObjectForKey:kFFImagePathKey];
	}
	
	return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
	[coder encodeObject:self.path forKey:kFFImagePathKey];
}

@end
