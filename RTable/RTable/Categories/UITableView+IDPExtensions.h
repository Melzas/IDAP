#import <UIKit/UIKit.h>

@interface UITableView (IDPExtensions)

// Dequeues or creates a cell of class |class|
// Cell reuse identifier must have the same name as a cell class
// Cell nib file name must have the same name as a cell class
// Nib file must contain only one top level object of any class
- (id)cellForClass:(Class)class;

- (void)updateTableViewWithBlock:(void(^)(void))updateBlock;

@end
