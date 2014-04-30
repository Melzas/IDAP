//
//  CMCompassViewController.m
//  Compo
//
//  Created by Anton Rayev on 4/25/14.
//  Copyright (c) 2014 Anton Rayev. All rights reserved.
//

#import "CMCompassViewController.h"

#import "CMUser.h"

#import "CMUserHeadingContext.h"

#import "CMCompassView.h"
#import "CMCompass.h"

static NSString * const kCMErrorMessage = @"Failed to retrieve user's heading";

@interface CMCompassViewController () <IDPModelObserver>
@property (nonatomic, retain)	CMUserHeadingContext		*headingContext;

@end

@implementation CMCompassViewController

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
	self.user = nil;
	self.headingContext = nil;
	
	[super dealloc];
}

#pragma mark -
#pragma mark View Lifecycle

-(void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
	CMUserHeadingContext *headingContext = [CMUserHeadingContext object];
	headingContext.user = self.user;
	
	self.headingContext = headingContext;
	[headingContext load];
}

- (void)viewDidDisappear:(BOOL)animated {
	self.headingContext = nil;
	
	[super viewDidDisappear:animated];
}

#pragma mark -
#pragma mark Accessors

IDPViewControllerViewOfClassGetterSynthesize(CMCompassView, compassView);

- (void)setHeadingContext:(CMUserHeadingContext *)headingContext {
	IDPNonatomicRetainPropertySynthesizeWithObserver(_headingContext, headingContext);
}

#pragma mark -
#pragma mark IDPModelObserver

- (void)modelDidLoad:(id)model {
	[self.compassView.compass setAngle:self.user.heading animated:YES];
}

- (void)modelDidFailToLoad:(id)model {
	[UIAlertView showErrorWithMessage:kCMErrorMessage];
}

@end
