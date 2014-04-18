//
//  FFMainViewController.m
//  FacebookFriends
//
//  Created by Anton Rayev on 3/17/14.
//  Copyright (c) 2014 Anton Rayev. All rights reserved.
//

#import "FFFriendsViewController.h"

#import "FFUsers.h"
#import "FFFacebookUsersContext.h"
#import "FFDatabaseUsersContext.h"

#import "FFFriendDetailsViewController.h"

#import "FFFriendsView.h"
#import "FFFriendCell.h"

static NSString * const kFFErrorMessage = @"Error while retrieving the list of friends";

@interface FFFriendsViewController ()
@property (nonatomic, readonly)	FFFriendsView			*friendsView;
@property (nonatomic, retain)	FFFacebookUsersContext	*facebookUsersContext;

@end

@implementation FFFriendsViewController

@dynamic friendsView;

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
	self.users = nil;
	self.facebookUsersContext = nil;
	
	[super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
		self.users = [FFUsers object];
	}
	
	return self;
}

#pragma mark -
#pragma mark View Lifecycle

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
	FFUsers *users = self.users;
	
	FFFacebookUsersContext *facebookUsersContext = [FFFacebookUsersContext object];
	self.facebookUsersContext = facebookUsersContext;
	facebookUsersContext.users = users;
	[facebookUsersContext load];
}

- (void)viewDidDisappear:(BOOL)animated {
	self.facebookUsersContext = nil;
	
	[super viewDidDisappear:animated];
}

#pragma mark -
#pragma mark Accessors

IDPViewControllerViewOfClassGetterSynthesize(FFFriendsView, friendsView);

- (void)setFacebookUsersContext:(FFFacebookUsersContext *)facebookUsersContext {	
	IDPNonatomicRetainPropertySynthesizeWithObserver(_facebookUsersContext, facebookUsersContext);
}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [self.users.models count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
		 cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	FFFriendCell *cell = [tableView dequeueCell:[FFFriendCell class]];
	FFUser *dataForCell = self.users.models[indexPath.row];
	cell.user = dataForCell;
	
	return cell;
}

#pragma mark -
#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	FFFriendDetailsViewController *friendDetailsViewController
		= [FFFriendDetailsViewController defaultNibController];
	
	friendDetailsViewController.user = self.users.models[indexPath.row];
	[self.navigationController pushViewController:friendDetailsViewController animated:YES];
}

#pragma mark -
#pragma maark IDPModelObserver

- (void)modelDidLoad:(id)model {
	FFFriendsView *friendsView = self.friendsView;
	
	[friendsView.tableView reloadData];
	[friendsView.loadingView removeFromSuperview];
}

- (void)modelDidUnload:(id)model {
	[self.friendsView.tableView reloadData];	
}

- (void)modelDidFailToLoad:(id)model {
	[UIAlertView showErrorWithMessage:kFFErrorMessage];
}

@end
