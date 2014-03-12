#import <UIKit/UIKit.h>

#import "IDPModelObserver.h"

@class RTTableModel;

@interface RTMainViewController : UIViewController <UITableViewDataSource, IDPModelObserver>
@property (nonatomic, retain)	RTTableModel	*tableModel;

- (IBAction)onAdd:(id)sender;
- (IBAction)onEdit:(id)sender;

@end
