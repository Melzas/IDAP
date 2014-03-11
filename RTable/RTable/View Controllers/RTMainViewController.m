#import "RTMainViewController.h"

#import "NSObject+IDPExtensions.h"
#import "UITableView+IDPExtensions.h"

#import "IDPObserver.h"

#import "RTTableModel.h"
#import "RTCellModel.h"

#import "RTMainView.h"
#import "RTCellView.h"


@interface RTMainViewController ()
@property (nonatomic, retain)	RTTableModel	*tableModel;
@property (nonatomic, readonly)	RTMainView		*mainView;
@property (nonatomic, retain)	IDPObserver		*observer;

@end

@implementation RTMainViewController

@dynamic mainView;

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
	self.tableModel = nil;
	self.observer = nil;
	
    [super dealloc];
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tableModel = [RTTableModel object];
		self.observer = [IDPObserver object];
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
	
	[self.tableModel addObserver:self];
	[self.tableModel load];
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
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [self.tableModel.cellModels count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
		 cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	RTCellView *cell = [self.mainView.tableView cellForClass:[RTCellView class]];
	RTCellModel *cellModel = self.tableModel.cellModels[indexPath.row];
	[cellModel addObserver:cell];
	[cellModel load];
	
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
#pragma mark IDPObserver

- (void)addObservableObject:(id<IDPObservableObject>)observableObject {
	[self.observer addObservableObject:observableObject];
}

- (void)removeObservableObject:(id<IDPObservableObject>)observableObject {
	[self.observer removeObservableObject:observableObject];
}

#pragma mark -
#pragma mark IDPModelObserver

- (void)modelDidLoad:(id)model {
	[self.mainView.spinner stopAnimating];
	self.mainView.spinnerBackgroundView.hidden = YES;
	[self.mainView.tableView reloadData];
}

@end
