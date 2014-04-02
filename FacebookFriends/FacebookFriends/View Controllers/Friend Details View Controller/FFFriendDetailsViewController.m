//
//  FFFriendDetailsViewController.m
//  FacebookFriends
//
//  Created by Anton Rayev on 3/27/14.
//  Copyright (c) 2014 Anton Rayev. All rights reserved.
//

#import "FFFriendDetailsViewController.h"

#import "FFUserDetailsLoadingContext.h"

#import "FFFriendDetailsView.h"

static NSString * const kFFErrorMessage = @"Error while retreiving friend details";

@interface FFFriendDetailsViewController ()
@property (nonatomic, readonly)	FFFriendDetailsView			*friendDetailsView;
@property (nonatomic, retain)	FFUserDetailsLoadingContext	*userDetailsLoadingContext;

@end

@implementation FFFriendDetailsViewController

@dynamic friendDetailsView;

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
	self.userDetailsLoadingContext = nil;
	self.userData = nil;
	
	[super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		self.userDetailsLoadingContext = [FFUserDetailsLoadingContext object];
    }
	
    return self;
}

#pragma mark -
#pragma mark View Lifecycle

- (void)viewWillAppear:(BOOL)animated {
	[self.userDetailsLoadingContext load];
	
	[super viewWillAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
	self.userDetailsLoadingContext = nil;
	
	[super viewDidDisappear:animated];
}

#pragma mark -
#pragma mark Accesssors

IDPViewControllerViewOfClassGetterSynthesize(FFFriendDetailsView, friendDetailsView);

- (void)setUserDetailsLoadingContext:(FFUserDetailsLoadingContext *)userDetailsLoadingContext {
	if (userDetailsLoadingContext != _userDetailsLoadingContext) {
		[_userDetailsLoadingContext cancel];
	}
	
	IDPNonatomicRetainPropertySynthesizeWithObserver(_userDetailsLoadingContext,
													 userDetailsLoadingContext);
}

- (void)setUserData:(FFUserData *)userData {
	IDPNonatomicRetainPropertySynthesize(_userData, userData);
	
	self.userDetailsLoadingContext.userData = userData;
}

#pragma mark -
#pragma mark IDPModelObserver

- (void)modelDidLoad:(id)model {
	[self.friendDetailsView fillFromModel:self.userData];
}

- (void)modelDidFailToLoad:(id)theModel {
	[UIAlertView showErrorWithMessage:kFFErrorMessage];
}

@end
