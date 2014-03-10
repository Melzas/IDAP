#import <UIKit/UIKit.h>

#import "IDPObserverProtocol.h"

@class RTTableModel;

@interface RTMainViewController : UIViewController <UITableViewDataSource, IDPObserver>
@property (nonatomic, readonly)	RTTableModel	*tableModel;

- (IBAction)onAdd:(id)sender;
- (IBAction)onEdit:(id)sender;

@end
