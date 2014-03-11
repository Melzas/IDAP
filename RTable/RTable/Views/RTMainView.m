#import "RTMainView.h"

@interface RTMainView ()

- (void)changeTableViewEditing;

@end

@implementation RTMainView

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
	self.tableView = nil;
	self.editButton = nil;
	
	[super dealloc];
}

- (void)awakeFromNib {
	[super awakeFromNib];
}

#pragma mark -
#pragma mark Accessors

- (void)setTableViewEditing:(BOOL)tableViewEditing {
	_tableViewEditing = tableViewEditing;
	
	[self changeTableViewEditing];
}

#pragma mark -
#pragma mark Private

- (void)changeTableViewEditing {
	[self.tableView setEditing:self.tableViewEditing animated:YES];
	self.editButton.title = self.tableViewEditing ? @"Done" : @"Edit";
}

@end
