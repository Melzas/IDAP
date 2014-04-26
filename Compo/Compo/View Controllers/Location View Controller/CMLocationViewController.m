//
//  CMLocationViewController.m
//  Compo
//
//  Created by Anton Rayev on 4/24/14.
//  Copyright (c) 2014 Anton Rayev. All rights reserved.
//

#import "CMLocationViewController.h"

#import "CMUser.h"

#import "CMUserLocationContext.h"

#import "CMLocationView.h"

static NSString * const kCMLocationError = @"Could not retrieve user's location";

@interface CMLocationViewController () <IDPModelObserver>
@property (nonatomic, retain)	CMUserLocationContext	*userLocationContext;

@end

@implementation CMLocationViewController

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
	self.user = nil;
	self.userLocationContext = nil;
	
	[super dealloc];
}

#pragma mark -
#pragma mark View Lifecycle

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
	self.locationView.loading = YES;
	
	CMUserLocationContext *userLocationContext = [CMUserLocationContext object];
	userLocationContext.user = self.user;
	
	self.userLocationContext = userLocationContext;
	[userLocationContext load];
}

- (void)viewDidDisappear:(BOOL)animated {
	[self.userLocationContext cancel];
	self.locationView.loading = NO;
	
	[super viewDidDisappear:animated];
}

#pragma mark -
#pragma mark Accessors

IDPViewControllerViewOfClassGetterSynthesize(CMLocationView, locationView);

- (void)setUserLocationContext:(CMUserLocationContext *)userLocationContext {
	IDPNonatomicRetainPropertySynthesizeWithObserver(_userLocationContext, userLocationContext);
}

#pragma mark -
#pragma mark IDPModelObserver

- (void)modelDidLoad:(id)model {
	self.userLocationContext = nil;
	
	CMLocationView *locationView = self.locationView;
	[locationView fillWithUser:self.user];
	locationView.loading = NO;
	
}

- (void)modelDidFailToLoad:(id)model {
	self.locationView.loading = NO;
	[UIAlertView showErrorWithMessage:kCMLocationError];
}

@end
