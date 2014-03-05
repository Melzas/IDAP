#import <UIKit/UIKit.h>

@interface RTStringViewController : UIViewController <UITableViewDataSource>

- (void)saveStorageToFile:(NSString *)fileName;
- (void)loadStorageFromFile:(NSString *)fileName;

- (IBAction)addButtonTapped:(id)addButton;
- (IBAction)editButtonTapped:(id)editButton;

@end
