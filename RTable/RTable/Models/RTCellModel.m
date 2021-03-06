#import "RTCellModel.h"

#import "NSObject+IDPExtensions.h"
#import "NSString+IDPExtensions.h"

#import "IDPImageModel.h"

static const NSUInteger kRTStringLength = 10;
static NSString * const kRTStringKey	= @"kRTStringKey";
static NSString * const kRTImageName	= @"Lenna.png";

@implementation RTCellModel

#pragma mark -
#pragma Class Methods

+ (instancetype)model {
	RTCellModel *model = [RTCellModel object];
	model.string = [NSString randomStringOfLength:kRTStringLength];
	
	return model;
}

#pragma mark -
#pragma mark Public

- (void)cleanup {
	self.string = nil;
	self.imageModel = nil;
}

- (void)prepareForLoad {
	self.imageModel = [IDPImageModel modelWithImageFromFilePath:kRTImageName];
}

- (void)performLoading {
	[self.imageModel load];
	
	[self finishLoading];
}

#pragma mark -
#pragma mark NSCoding

- (id)initWithCoder:(NSCoder *)decoder {
	self = [super init];
	if (self) {
		self.string = [decoder decodeObjectForKey:kRTStringKey];
	}
	
	return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
	[coder encodeObject:self.string forKey:kRTStringKey];
}

@end
