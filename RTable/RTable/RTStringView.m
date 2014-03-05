#import "RTStringView.h"

static NSString * const kRTCellIdentifier = @"kRTCellReuseIdentifier";
static NSString * const kRTCellImageName = @"Lenna.png";

@interface RTStringView ()
@property (nonatomic, retain)	UIImage	*cellImage;

@end

@implementation RTStringView

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
	self.tableView = nil;
	self.editButton = nil;
	self.cellImage = nil;
	
	[super dealloc];
}

- (void)awakeFromNib {
	[super awakeFromNib];
	
	self.cellImage = [UIImage imageNamed:kRTCellImageName];
}

#pragma mark -
#pragma mark Public

- (UITableViewCell *)availableCell {
	UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kRTCellIdentifier];
	if (!cell) {
		cell = [[UITableViewCell alloc]
				initWithStyle:UITableViewCellStyleDefault
				reuseIdentifier:kRTCellIdentifier];
		cell.imageView.image = self.cellImage;
		[cell autorelease];
	}
	
	return cell;
}

- (void)changeEditingMode {
	if ([self.tableView isEditing]) {
		self.editButton.title = @"Edit";
		[self.tableView setEditing:NO animated:YES];
	} else {
		self.editButton.title = @"Done";
		[self.tableView setEditing:YES animated:YES];
	}
}

@end
