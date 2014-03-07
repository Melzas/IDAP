#import "RTCellModel.h"

#import "NSObject+IDPExtensions.h"
#import "NSString+IDPExtensions.h"

static const NSUInteger kRTStringLength = 12;

@implementation RTCellModel

#pragma mark -
#pragma Class Methods

+ (instancetype)model {
	RTCellModel *model = [RTCellModel object];
	model.string = [NSString randomStringOfLength:kRTStringLength];
	
	return model;
}

@end
