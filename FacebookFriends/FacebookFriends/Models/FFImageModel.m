#import "FFImageModel.h"

#import "NSObject+IDPExtensions.h"
#import "NSBundle+IDPExtensions.h"

#import "FFImageCache.h"

#import "FFUser.h"

static NSString * const kFFCacheFolder	= @"Caches/Images";

@interface FFImageModel () <IDPModelObserver>
@property (nonatomic, copy)		NSString	*path;
@property (nonatomic, retain)	UIImage		*image;

@property (nonatomic, retain)	IDPModelMixin		*model;
@property (nonatomic, retain)	IDPURLConnection	*connection;
@property (nonatomic, retain)	NSData				*imageData;
@property (nonatomic, readonly)	NSString			*savePath;

@end

@implementation FFImageModel

@dynamic path;
@dynamic image;
@dynamic type;
@dynamic savePath;

@synthesize cache = _cache;
@synthesize model = _model;
@synthesize connection = _connection;
@synthesize imageData = _imageData;

#pragma mark -
#pragma mark Class Methods

+ (id)managedObjectWithPath:(NSString *)path {
	FFImageModel *imageModel = [FFImageModel managedObject];
	imageModel.path = path;
	
	return imageModel;
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)cleanup {
	self.model = nil;
	self.connection = nil;
	self.imageData = nil;
}

- (id)				initWithEntity:(NSEntityDescription *)entity
	insertIntoManagedObjectContext:(NSManagedObjectContext *)context
{
	if (self = [super initWithEntity:entity insertIntoManagedObjectContext:context]) {
		self.model = [IDPModelMixin modelWithTarget:self];
		[self extendWithObject:self.model];
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

- (void)cancel {
	self.connection = nil;
	
	[self.model cancel];
}

#pragma mark -
#pragma mark Private

- (void)awakeFromFetch {
	[super awakeFromFetch];
	
	self.imageData = [NSData dataWithContentsOfFile:self.savePath];
}

- (void)didTurnIntoFault {
	[self cleanup];
	
	[super didTurnIntoFault];
}

- (void)didSave {
	[self.imageData writeToFile:self.savePath atomically:YES];
	
	[super didSave];
}

- (BOOL)load {
	if (![self.model load]) {
		return NO;
	}
	
	if (nil != self.image) {
		[self finishLoading];
		return YES;
	}

	NSURL *imageUrl = [NSURL URLWithString:self.path];
	self.connection = [IDPURLConnection connectionToURL:imageUrl];
	[self.connection load];
	
	return YES;
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
	[self failLoading];
	
	self.connection = nil;
}

@end
