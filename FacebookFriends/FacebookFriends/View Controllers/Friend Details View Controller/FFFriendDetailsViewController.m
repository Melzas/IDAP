//
//  FFFriendDetailsViewController.m
//  FacebookFriends
//
//  Created by Anton Rayev on 3/27/14.
//  Copyright (c) 2014 Anton Rayev. All rights reserved.
//

#import "FFFriendDetailsViewController.h"

#import "FFFacebookUserContext.h"

#import "FFFriendDetailsView.h"

static NSString * const kFFErrorMessage = @"Error while retreiving friend details";

@interface FFFriendDetailsViewController ()
@property (nonatomic, readonly)	FFFriendDetailsView		*friendDetailsView;
@property (nonatomic, retain)	FFFacebookUserContext	*facebookUserContext;

@end

@implementation FFFriendDetailsViewController

@dynamic friendDetailsView;

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
	self.facebookUserContext = nil;
	self.user = nil;
	
	[super dealloc];
}

#pragma mark -
#pragma mark View Lifecycle

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
	self.facebookUserContext = [FFFacebookUserContext object];
	[self.facebookUserContext load];
}

- (void)viewDidDisappear:(BOOL)animated {
	self.facebookUserContext = nil;
	
	[super viewDidDisappear:animated];
}

#pragma mark -
#pragma mark Accesssors

IDPViewControllerViewOfClassGetterSynthesize(FFFriendDetailsView, friendDetailsView);

- (void)setFacebookUserContext:(FFFacebookUserContext *)facebookUserContext {
	IDPNonatomicRetainPropertySynthesizeWithObserver(_facebookUserContext, facebookUserContext);
	
	facebookUserContext.user = self.user;
}

- (void)setUser:(FFUser *)user {
	IDPNonatomicRetainPropertySynthesize(_user, user);
}

#pragma mark -
#pragma mark IDPModelObserver

- (void)modelDidLoad:(id)model {
	[self.friendDetailsView fillFromModel:self.user];
}

- (void)modelDidFailToLoad:(id)theModel {
	[UIAlertView showErrorWithMessage:kFFErrorMessage];
}

@end
