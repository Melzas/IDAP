//
//  FFLoginViewController.m
//  FacebookFriends
//
//  Created by Anton Rayev on 3/26/14.
//  Copyright (c) 2014 Anton Rayev. All rights reserved.
//

#import "FFLoginViewController.h"

#import "FFLoginView.h"

@interface FFLoginViewController ()

@end

@implementation FFLoginViewController

@dynamic loginView;

#pragma mark -
#pragma mark Accessors

IDPViewControllerViewOfClassGetterSynthesize(FFLoginView, loginView);

#pragma mark -
#pragma mark FBLoginViewDelegate

- (void)loginViewShowingLoggedInUser:(FBLoginView *)loginView {

}

- (void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView {

}

@end
