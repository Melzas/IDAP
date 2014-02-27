#import <UIKit/UIKit.h>

@interface RTMainView : UIView
@property (nonatomic, retain)	IBOutlet UITableView				*tableView;
@property (nonatomic, retain)	IBOutlet UIBarButtonItem			*editButton;
@property (nonatomic, retain)	IBOutlet UIView						*loadingView;
@property (nonatomic, retain)	IBOutlet UIActivityIndicatorView	*spinner;

@property (nonatomic, assign, getter = isTableViewEditing)	BOOL	tableViewEditing;

@end
