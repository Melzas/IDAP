//
//  FFMainViewController.m
//  FacebookFriends
//
//  Created by Anton Rayev on 3/17/14.
//  Copyright (c) 2014 Anton Rayev. All rights reserved.
//

#import "FFMainViewController.h"

#import "FFUsersData.h"
#import "FFUsersLoadingContext.h"

#import "FFMainView.h"
#import "FFCellView.h"

@interface FFMainViewController ()
@property (nonatomic, readonly)	FFMainView	*mainView;

@end

@implementation FFMainViewController

@dynamic mainView;

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
	self.usersData = nil;
	
	[super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

#pragma mark -
#pragma mark Accessors

IDPViewControllerViewOfClassGetterSynthesize(FFMainView, mainView);

- (void)setUsersData:(FFUsersData *)usersData {
	IDPNonatomicRetainPropertySynthesizeWithObserver(_usersData, usersData);
}

#pragma mark -
#pragma mark FBLoginViewDelegate

- (void)loginViewShowingLoggedInUser:(FBLoginView *)loginView {
	FFUsersLoadingContext *usersLoadingContext = [FFUsersLoadingContext object];
	[usersLoadingContext loadUsers:self.usersData];
}

- (void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView {
	[self.usersData dump];
}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [self.usersData.users count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
		 cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	FFCellView *cell = [tableView dequeueCell:[FFCellView class]];
	FFUserData *dataForCell = self.usersData.users[indexPath.row];
	cell.userData = dataForCell;
	
	return cell;
}

#pragma mark -
#pragma maark IDPModelObserver

- (void)modelDidLoad:(id)model {
	[self.mainView.tableView reloadData];
}

- (void)modelDidUnload:(id)model {
	[self.mainView.tableView reloadData];	
}

- (void)modelDidFailToLoad:(id)model {
	[UIAlertView showErrorWithMessage:@"Error while retrieving the list of friends"];
}

@end
