#import "RTCellView.h"

#import "RTCellModel.h"

@implementation RTCellView

#pragma mark -
#pragma mark Accessors

- (NSString *)restorationIdentifier {
	return NSStringFromClass([self class]);
}

#pragma mark -
#pragma mark Public

- (void)fillFromModel:(RTCellModel *)cellModel {
	self.textLabel.text = cellModel.string;
}

@end
