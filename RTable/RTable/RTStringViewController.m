#import "RTStringViewController.h"

#import "RTStringView.h"
#import "NSObject+IDPExtensions.h"
#import "RTStringStorage.h"
#import "RTRandomStringGenerator.h"

static const NSUInteger kRTStringCount = 10;
static const NSUInteger kRTStringLength = 12;

@interface RTStringViewController ()
@property (nonatomic, readonly)				RTStringView			*stringView;
@property (nonatomic, retain, readwrite)	RTStringStorage			*stringStorage;
@property (nonatomic, retain)				RTRandomStringGenerator	*randomStringGenerator;

- (void)fillStorageWithRandomStrings;

@end

@implementation RTStringViewController

@dynamic stringView;

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
	self.stringStorage = nil;
	self.randomStringGenerator = nil;
	
    [super dealloc];
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		self.randomStringGenerator =
			[RTRandomStringGenerator generatorWithStringLength:kRTStringLength];
		
        self.stringStorage = [RTStringStorage object];
		if (![self.stringStorage loadFromFile]) {
			[self fillStorageWithRandomStrings];
		}
    }
	
    return self;
}

#pragma mark -
#pragma mark Accessors

- (RTStringView *)stringView {
	if ([self isViewLoaded] && [self.view isKindOfClass:[RTStringView class]]) {
		return (RTStringView *)self.view;
	}
	
	return  nil;
}


#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [self.stringStorage.strings count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
		 cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = [self.stringView availableCell];
	cell.textLabel.text = [self.stringStorage strings][indexPath.row];
	
	return cell;
}

- (void)  tableView:(UITableView *)tableView
 commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
  forRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (editingStyle == UITableViewCellEditingStyleDelete) {
		[self.stringStorage removeString:self.stringStorage.strings[indexPath.row]];
		[tableView deleteRowsAtIndexPaths:@[indexPath]
						 withRowAnimation:UITableViewRowAnimationFade];
	}
}

- (void)  tableView:(UITableView *)tableView
 moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath
		toIndexPath:(NSIndexPath *)destinationIndexPath
{
	[self.stringStorage moveStringFromIndex:sourceIndexPath.row toIndex:destinationIndexPath.row];
}

#pragma mark -
#pragma mark Public

- (IBAction)addButtonTapped:(id)addButton {
	[self.stringStorage addString:[self.randomStringGenerator generateRandomString]];
	
	NSUInteger lastRow = [self.stringView.tableView numberOfRowsInSection:0];
	NSIndexPath *pathForLastRow = [NSIndexPath indexPathForRow:lastRow inSection:0];
	[self.stringView.tableView insertRowsAtIndexPaths:@[pathForLastRow]
									 withRowAnimation:UITableViewRowAnimationTop];
}

- (IBAction)editButtonTapped:(id)editButton {
	[self.stringView changeEditingMode];
}

#pragma mark -
#pragma mark Private

- (void)fillStorageWithRandomStrings {
	for (NSUInteger i = 0; i < kRTStringCount; ++i) {
		[self.stringStorage addString:[self.randomStringGenerator generateRandomString]];
	}
}

@end
