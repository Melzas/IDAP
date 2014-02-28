#import "RTStringViewController.h"

#import "NSObject+IDPExtensions.h"
#import "RTStringStorage.h"
#import "RTRandomStringGenerator.h"

static const NSUInteger kRTStringCount = 10;
static const NSUInteger kRTStringLength = 12;

static NSString * const kRTCellIdentifier = @"kRTCell";

@interface RTStringViewController ()
@property (nonatomic, retain, readwrite)	RTStringStorage			*stringStorage;
@property (nonatomic, retain, readwrite)	RTRandomStringGenerator	*randomStringGenerator;

@end

@implementation RTStringViewController

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
        self.stringStorage = [RTStringStorage object];
		self.randomStringGenerator =
			[RTRandomStringGenerator generatorWithStringLength:kRTStringLength];
		for (NSUInteger i = 0; i < kRTStringCount; ++i) {
			[self.stringStorage addString:[self.randomStringGenerator generateRandomString]];
		}
    }
    return self;
}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [self.stringStorage.strings count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
		 cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kRTCellIdentifier];
	if (!cell) {
		cell = [[UITableViewCell alloc]
				initWithStyle:UITableViewCellStyleDefault
			  reuseIdentifier:kRTCellIdentifier];
	}
	cell.textLabel.text = [self.stringStorage strings][indexPath.row];
	return cell;
}

- (void)  tableView:(UITableView *)tableView
 commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
  forRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (editingStyle == UITableViewCellEditingStyleDelete) {
		[self.stringStorage removeString:self.stringStorage.strings[indexPath.row]];
		[self.tableView deleteRowsAtIndexPaths:@[indexPath]
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
	NSUInteger lastRow = [self.tableView numberOfRowsInSection:0];
	NSIndexPath *pathForLastRow = [NSIndexPath indexPathForRow:lastRow inSection:0];
	[self.tableView insertRowsAtIndexPaths:@[pathForLastRow]
						  withRowAnimation:UITableViewRowAnimationTop];
}

- (IBAction)editButtonTapped:(id)editButton {
	if ([self.tableView isEditing]) {
		[editButton setTitle:@"Edit"];
		[self.tableView setEditing:NO animated:YES];
	} else {
		[editButton setTitle:@"Done"];
		[self.tableView setEditing:YES animated:YES];
	}
}


@end
