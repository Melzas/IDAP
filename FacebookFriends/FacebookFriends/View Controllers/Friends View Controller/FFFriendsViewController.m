//
//  FFMainViewController.m
//  FacebookFriends
//
//  Created by Anton Rayev on 3/17/14.
//  Copyright (c) 2014 Anton Rayev. All rights reserved.
//

#import "FFFriendsViewController.h"

#import "FFUsersData.h"
#import "FFUsersLoadingContext.h"

#import "FFFriendDetailsViewController.h"

#import "FFFriendsView.h"
#import "FFFriendCell.h"

static NSString * const kFFErrorMessage = @"Error while retrieving the list of friends";

@interface FFFriendsViewController ()
@property (nonatomic, readonly)	FFFriendsView			*friendsView;
@property (nonatomic, retain)	FFUsersLoadingContext	*usersLoadingContext;

@end

@implementation FFFriendsViewController

@dynamic friendsView;

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
	self.usersData = nil;
	self.usersLoadingContext = nil;
	
	[super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) {
		self.usersLoadingContext = [FFUsersLoadingContext object];
	}
	
	return self;
}

#pragma mark -
#pragma mark View Lifecycle

- (void)viewWillAppear:(BOOL)animated {
	FFUsersLoadingContext *usersLoadingContext = self.usersLoadingContext;
	usersLoadingContext.usersData = self.usersData;
	
	[usersLoadingContext load];
	
	[super viewWillAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
	[self.usersLoadingContext cancel];
	
	[super viewDidDisappear:animated];
}


#pragma mark -
#pragma mark Accessors

IDPViewControllerViewOfClassGetterSynthesize(FFFriendsView, friendsView);

- (void)setUsersLoadingContext:(FFUsersLoadingContext *)usersLoadingContext {
	IDPNonatomicRetainPropertySynthesizeWithObserver(_usersLoadingContext, usersLoadingContext);
}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [self.usersData.users count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
		 cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	FFFriendCell *cell = [tableView dequeueCell:[FFFriendCell class]];
	FFUserData *dataForCell = self.usersData.users[indexPath.row];
	cell.userData = dataForCell;
	
	return cell;
}

#pragma mark -
#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	FFFriendDetailsViewController *friendDetailsViewController
		= [FFFriendDetailsViewController defaultNibController];
	
	friendDetailsViewController.userData = self.usersData.users[indexPath.row];
	[self.navigationController pushViewController:friendDetailsViewController animated:YES];
}

#pragma mark -
#pragma maark IDPModelObserver

- (void)modelDidLoad:(id)model {
	[self.friendsView.tableView reloadData];
}

- (void)modelDidUnload:(id)model {
	[self.friendsView.tableView reloadData];	
}

- (void)modelDidFailToLoad:(id)model {
	[UIAlertView showErrorWithMessage:kFFErrorMessage];
}

@end
