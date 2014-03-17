#import "FFImageModel.h"

#import "NSObject+IDPExtensions.h"
#import "NSBundle+IDPExtensions.h"

#import "FFImageCache.h"

static NSString * const kFFPathKey	= @"kFFPathKey";
static NSString	* const kFFImageKey	= @"kFFImageKey";

@interface FFImageModel () <IDPModelObserver>
@property (nonatomic, retain)	UIImage		*image;
@property (nonatomic, copy)		NSString	*path;

@property (nonatomic, retain)	IDPURLConnection	*connection;

@end

@implementation FFImageModel

#pragma mark -
#pragma mark Class Methods

+ (id)modelWithPath:(NSString *)path {
	return [[[self alloc] initWithPath:path] autorelease];
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)cleanup {
	self.image = nil;
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
	if (connection != _connection) {
		[_connection cancel];
	}
	
	IDPNonatomicRetainPropertySynthesizeWithObserver(_connection, connection);
}

#pragma mark -
#pragma mark Public

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
	if (nil != self.image) {
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
	self.image = [UIImage imageWithData:connection.data];
	
	[self finishLoading];
	self.connection = nil;
}

- (void)modelDidFailToLoad:(id)model {
	[self failLoading];
	
	self.connection = nil;
}

#pragma mark -
#pragma mark NSCoding

- (id)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if (self) {
		self.path = [decoder decodeObjectForKey:kFFPathKey];
		self.image = [decoder decodeObjectForKey:kFFImageKey];
	}
	
	return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
	[coder encodeObject:self.path forKey:kFFPathKey];
	[coder encodeObject:self.image forKey:kFFImageKey];
}

@end
