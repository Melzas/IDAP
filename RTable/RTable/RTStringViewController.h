#import <UIKit/UIKit.h>

@class RTTableModel;

@interface RTStringViewController : UIViewController <UITableViewDataSource>
@property (nonatomic, readonly)	RTTableModel	*stringStorage;

- (IBAction)addButtonTapped:(id)addButton;
- (IBAction)editButtonTapped:(id)editButton;

@end
