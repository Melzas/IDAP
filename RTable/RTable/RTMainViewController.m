#import "RTMainViewController.h"

#import "NSObject+IDPExtensions.h"
#import "UITableView+IDPExtensions.h"

#import "RTTableModel.h"
#import "RTCellModel.h"

#import "RTMainView.h"
#import "RTCellView.h"


@interface RTMainViewController ()
@property (nonatomic, retain, readwrite)	RTTableModel	*tableModel;
@property (nonatomic, readonly)				RTMainView	*mainView;

@end

@implementation RTMainViewController

@dynamic mainView;

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
	self.tableModel = nil;
	
    [super dealloc];
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tableModel = [RTTableModel object];
    }
	
    return self;
}

#pragma mark -
#pragma mark Accessors

- (RTMainView *)mainView {
	if ([self isViewLoaded] && [self.view isKindOfClass:[RTMainView class]]) {
		return (RTMainView *)self.view;
	}
	
	return  nil;
}

#pragma mark -
#pragma mark View Lifecycle

- (void)viewDidLoad {
	[super viewDidLoad];
	
	[self.tableModel load];
}

#pragma mark -
#pragma mark Public

- (IBAction)onAdd:(id)sender {
	[self.tableModel addCellModel:[RTCellModel model]];
	
	NSUInteger lastRow = [self.mainView.tableView numberOfRowsInSection:0];
	NSIndexPath *pathForLastRow = [NSIndexPath indexPathForRow:lastRow inSection:0];
	
	UITableView *tableView = self.mainView.tableView;
	[tableView updateTableViewWithBlock:^{
		[tableView insertRowsAtIndexPaths:@[pathForLastRow]
						 withRowAnimation:UITableViewRowAnimationTop];
	}];
}

- (IBAction)onEdit:(id)sender {
	self.mainView.tableViewEditing = !self.mainView.tableViewEditing;
}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [self.tableModel.cellModels count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
		 cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	RTCellView *cell = [self.mainView.tableView cellForClass:[RTCellView class]];
	cell.textLabel.text = [self.tableModel.cellModels[indexPath.row] string];
	
	return cell;
}

- (void)  tableView:(UITableView *)tableView
 commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
  forRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (editingStyle == UITableViewCellEditingStyleDelete) {
		[self.tableModel removeCellModel:self.tableModel.cellModels[indexPath.row]];
		[tableView updateTableViewWithBlock:^{
			[tableView deleteRowsAtIndexPaths:@[indexPath]
							 withRowAnimation:UITableViewRowAnimationFade];
		}];
	}
}

- (void)  tableView:(UITableView *)tableView
 moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath
		toIndexPath:(NSIndexPath *)destinationIndexPath
{
	[self.tableModel moveCellModelFromIndex:sourceIndexPath.row
									toIndex:destinationIndexPath.row];
}

@end
