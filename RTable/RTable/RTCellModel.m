#import "RTCellModel.h"

#import "NSObject+IDPExtensions.h"
#import "NSString+IDPExtensions.h"

static const NSUInteger kRTStringLength = 10;
static NSString * const kRTStringKey	= @"kRTStringKey";

@implementation RTCellModel

#pragma mark -
#pragma Class Methods

+ (instancetype)model {
	RTCellModel *model = [RTCellModel object];
	model.string = [NSString randomStringOfLength:kRTStringLength];
	
	return model;
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
