#import "FFImageModel.h"

#import "NSObject+IDPExtensions.h"
#import "NSBundle+IDPExtensions.h"

#import "FFImageCache.h"

#import "FFUser.h"

static NSString * const kFFCacheFolder	= @"Caches";

@interface FFImageModel () <IDPModelObserver>
@property (nonatomic, copy)		NSString	*path;
@property (nonatomic, retain)	UIImage		*image;

@property (nonatomic, retain)	IDPURLConnection	*connection;
@property (nonatomic, retain)	NSData				*imageData;
@property (nonatomic, readonly)	NSString			*savePath;

@end

@implementation FFImageModel

@dynamic image;
@dynamic savePath;

#pragma mark -
#pragma mark Class Methods

+ (id)modelWithPath:(NSString *)path {
	return [[[self alloc] initWithPath:path] autorelease];
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)cleanup {
	self.imageData = nil;
	self.path = nil;
	self.connection = nil;
}

- (id)initWithPath:(NSString *)path {
	FFImageCache *cache = [FFImageCache sharedObject];
	FFImageModel *imageModel = [cache cachedImageForPath:path];
	
	if (nil != imageModel) {
		[self autorelease];
		return [imageModel retain];
	}
	
    self = [super init];
    if (self) {
		self.path = path;
		[cache addImage:self];
    }
	
    return self;
}

#pragma mark -
#pragma mark - Accessors

- (void)setConnection:(IDPURLConnection *)connection {
	IDPNonatomicRetainPropertySynthesizeWithObserver(_connection, connection);
}

- (UIImage *)image {
	return [UIImage imageWithData:self.imageData];
}

- (NSString *)savePath {
	NSString *libraryPath = [NSFileManager libraryDirectoryPath];
	NSString *cachePath = [libraryPath stringByAppendingPathComponent:kFFCacheFolder];
	NSString *imageName = [self.path lastPathComponent];
	
	return [cachePath stringByAppendingPathComponent:imageName];
}

#pragma mark -
#pragma mark Public

- (void)save {
	[self.imageData writeToFile:self.savePath atomically:YES];
}

- (void)loadFromFile {
	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
		if (nil == self.imageData) {
			self.imageData = [NSData dataWithContentsOfFile:self.savePath];
		}
		
		nil == self.imageData ? [self failLoading] : [self finishLoading];
	});
}

- (void)cancel {
	self.connection = nil;
	
	[super cancel];
}

- (oneway void)release {
    @synchronized (self) {
		[super release];
		
        if (1 == [self retainCount]) {
            [self.cache removeImage:self];
        }
    }
}

#pragma mark -
#pragma mark Private

- (void)performLoading {
	if (nil != self.imageData) {
		[self finishLoading];
		return;
	}
	
	NSURL *imageUrl = [NSURL URLWithString:self.path];
	self.connection = [IDPURLConnection connectionToURL:imageUrl];
	[self.connection load];
}

#pragma mark -
#pragma mark IDPModelObserver

- (void)modelDidLoad:(id)model {
	IDPURLConnection *connection = self.connection;
	self.imageData = connection.data;
	
	[self finishLoading];
	self.connection = nil;
}

- (void)modelDidFailToLoad:(id)model {
	[self loadFromFile];
	
	self.connection = nil;
}

@end
