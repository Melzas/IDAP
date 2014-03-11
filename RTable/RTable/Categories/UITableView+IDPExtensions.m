#import "UITableView+IDPExtensions.h"

#import "NSBundle+IDPExtensions.h"

@implementation UITableView (IDPExtensions)

- (id)cellForClass:(Class)class {
	NSString *className = NSStringFromClass(class);
	id cell = [self dequeueReusableCellWithIdentifier:className];
	
	if (nil == cell) {
		cell = [[NSBundle mainBundle] loadClass:class];
	}
	
	return cell;
}

- (void)updateTableViewWithBlock:(void(^)(void))updateBlock {
	[self beginUpdates];
	updateBlock();
	[self endUpdates];
}

@end
