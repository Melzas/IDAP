#import "FFImageModel.h"

#import "NSObject+IDPExtensions.h"
#import "NSBundle+IDPExtensions.h"

#import "FFImageCache.h"

static NSString * const kFFPathKey	= @"kFFPathKey";
static NSString	* const kFFImageKey	= @"kFFImageKey";

@interface FFImageModel ()
@property (nonatomic, retain)	UIImage		*image;
@property (nonatomic, copy)		NSString	*path;

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
	NSLog(@"%@", self.path);
	
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
#pragma mark Private

- (void)performLoading {
	if (nil != self.image) {
		[self finishLoading];
		return;
	}
	
	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
		NSURL *imageUrl = [NSURL URLWithString:self.path];
		self.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageUrl]];
		
		[self finishLoading];
	});
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

-(id)retain {
	NSString *path = [self.path lastPathComponent];
	if (![path containString:@"q"]) {
		NSLog(@"%@: %i", path, [self retainCount]);
	}
	
	return [super retain];
}

- (oneway void)release {
	NSString *path = [self.path lastPathComponent];
	if (![path containString:@"q"]) {
		NSLog(@"%@: %i", path, [self retainCount]);
	}
	
    @synchronized (self) {
        [super release];
        
        if (1 == [self retainCount]) {
            FFImageCache *cache = [FFImageCache sharedObject];
 //           [cache removeImage:self];
        }
    }
}

@end
