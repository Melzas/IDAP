#import <UIKit/UIKit.h>

@class RTTableModel;

@interface RTMainViewController : UIViewController <UITableViewDataSource>
@property (nonatomic, readonly)	RTTableModel	*tableModel;

- (IBAction)onAdd:(id)sender;
- (IBAction)onEdit:(id)sender;

@end
