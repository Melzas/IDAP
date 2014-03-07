#import "UITableView+IDPExtensions.h"

@implementation UITableView (IDPExtensions)

- (id)cellForClass:(Class)class {
	NSString *className = NSStringFromClass(class);
	id cell = [self dequeueReusableCellWithIdentifier:className];
	
	if (nil == cell) {
		NSArray *nibObjects = [[NSBundle mainBundle] loadNibNamed:className owner:nil options:nil];
		
		for(id object in nibObjects) {
			if ([object isMemberOfClass:class]) {
				cell = object;
				break;
			}
		}
	}
	
	return cell;
}

- (void)updateTableViewWithBlock:(void(^)(void))updateBlock {
	[self beginUpdates];
	updateBlock();
	[self endUpdates];
}

@end
