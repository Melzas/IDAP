#import "RTCellView.h"

@implementation RTCellView

- (NSString *)restorationIdentifier {
	return NSStringFromClass([self class]);
}

@end
