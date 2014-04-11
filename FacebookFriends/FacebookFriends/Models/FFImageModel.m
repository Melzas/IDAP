#import "FFImageModel.h"

#import "NSObject+IDPExtensions.h"
#import "NSBundle+IDPExtensions.h"

#import "FFImageCache.h"

#import "FFUser.h"

@interface FFImageModel () <IDPModelObserver>
@property (nonatomic, copy)		NSString	*path;
@property (nonatomic, retain)	UIImage		*image;
@property (nonatomic, retain)	FFUser		*user;

@property (nonatomic, retain)	IDPModelMixin		*model;
@property (nonatomic, retain)	IDPURLConnection	*connection;

@end

@implementation FFImageModel

@dynamic path;
@dynamic type;
@dynamic user;

@synthesize image = _image;
@synthesize cache = _cache;
@synthesize model = _model;
@synthesize connection = _connection;

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
	self.image = nil;
	self.connection = nil;
	self.model = nil;
}

- (void)awakeFromInsert {
	[super awakeFromInsert];
	
	self.model = [IDPModelMixin modelWithTarget:self];
	[self extendWithObject:self.model];
}

#pragma mark -
#pragma mark - Accessors

- (void)setConnection:(IDPURLConnection *)connection {
	IDPNonatomicRetainPropertySynthesizeWithObserver(_connection, connection);
}

#pragma mark -
#pragma mark Public

- (void)cancel {
	self.connection = nil;
	
	[self.model cancel];
}

#pragma mark -
#pragma mark Private

- (void)didTurnIntoFault {
	[self cleanup];
	
	[super didTurnIntoFault];
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
	self.image = [UIImage imageWithData:connection.data];
	
	[self finishLoading];
	self.connection = nil;
}

- (void)modelDidFailToLoad:(id)model {
	[self failLoading];
	
	self.connection = nil;
}

@end
