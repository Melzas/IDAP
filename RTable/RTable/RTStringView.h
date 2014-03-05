#import <UIKit/UIKit.h>

@interface RTStringView : UIView
@property (nonatomic, retain)	IBOutlet UITableView		*tableView;
@property (nonatomic, retain)	IBOutlet UIBarButtonItem	*editButton;

- (UITableViewCell *)availableCell;
- (void)changeEditingMode;

@end
