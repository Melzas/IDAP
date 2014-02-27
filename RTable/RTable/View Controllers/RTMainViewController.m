#import "RTMainViewController.h"

#import "NSObject+IDPExtensions.h"
#import "UITableView+IDPExtensions.h"

#import "IDPPropertyMacros.h"

#import "RTTableModel.h"
#import "RTCellModel.h"

#import "RTMainView.h"
#import "RTCellView.h"


@interface RTMainViewController ()
@property (nonatomic, readonly)	RTMainView		*mainView;

- (void)loadTableModel;

@end

@implementation RTMainViewController

@dynamic mainView;

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
	self.tableModel = nil;
	
    [super dealloc];
}

#pragma mark -
#pragma mark View Lifecycle

- (void)didReceiveMemoryWarning {
	[self.tableModel dump];
	
	[super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark Accessors

- (RTMainView *)mainView {
	if ([self isViewLoaded] && [self.view isKindOfClass:[RTMainView class]]) {
		return (RTMainView *)self.view;
	}
	
	return  nil;
}

- (void)setTableModel:(RTTableModel *)tableModel {
	IDPNonatomicRetainPropertySynthesizeWithObserver(_tableModel, tableModel);

	[self loadTableModel];
}

#pragma mark -
#pragma mark Interface Handling

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
#pragma mark Private

- (void)loadTableModel {
	self.mainView.loadingView.hidden = NO;
	
	[self.tableModel load];
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
	RTCellModel *cellModel = self.tableModel.cellModels[indexPath.row];
	cell.model = cellModel;
	
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

#pragma mark -
#pragma mark IDPModelObserver

- (void)modelDidLoad:(id)model {
	RTMainView *mainView = self.mainView;
	
	mainView.loadingView.hidden = YES;
	[mainView.tableView reloadData];
}

@end
