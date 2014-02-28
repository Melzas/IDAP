#import <UIKit/UIKit.h>

@class RTStringStorage;
@class RTRandomStringGenerator;

@interface RTStringViewController : UIViewController <UITableViewDataSource>
@property (nonatomic, readonly)	RTStringStorage			*stringStorage;
@property (nonatomic, readonly) RTRandomStringGenerator	*randomStringGenerator;
@property (nonatomic, retain)	IBOutlet UITableView	*tableView;

- (IBAction)addButtonTapped:(id)addButton;
- (IBAction)editButtonTapped:(id)editButton;

@end
