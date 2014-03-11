#import "RTCellModel.h"

#import "NSObject+IDPExtensions.h"
#import "NSString+IDPExtensions.h"

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

- (void)performLoading {
	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
		sleep(1 + arc4random_uniform(2));
		self.image = [UIImage imageNamed:kRTImageName];

		[self finishLoading];
	});
}

- (void)cleanup {
	self.string = nil;
	self.image = nil;
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
