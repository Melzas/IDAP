#import <UIKit/UIKit.h>

@class RTStringStorage;

@interface RTStringViewController : UIViewController <UITableViewDataSource>
@property (nonatomic, readonly)	RTStringStorage	*stringStorage;

- (IBAction)addButtonTapped:(id)addButton;
- (IBAction)editButtonTapped:(id)editButton;

@end
