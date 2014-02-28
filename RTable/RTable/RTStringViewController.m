#import "RTStringViewController.h"

#import "NSObject+IDPExtensions.h"
#import "RTStringStorage.h"

@interface RTStringViewController ()
@property (nonatomic, retain, readwrite)	RTStringStorage	*stringStorage;

@end

@implementation RTStringViewController

- (void)dealloc {
	self.stringStorage = nil;
	
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.stringStorage = [RTStringStorage object];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [self.stringStorage.strings count] + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
		 cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StringCell"];
	if (!cell) {
		cell = [UITableViewCell object];
	}
	return cell;
}

@end
