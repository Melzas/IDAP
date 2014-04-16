//
//  FFLoginView.m
//  FacebookFriends
//
//  Created by Anton Rayev on 3/26/14.
//  Copyright (c) 2014 Anton Rayev. All rights reserved.
//

#import "FFLoginView.h"

static NSString * const kFFNotLoggedInMessage = @"You are not logged in";
static NSString * const kFFLoggedInMessage	  = @"You are logged in as:";

@implementation FFLoginView

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
	self.loggedInLabel = nil;
	self.usernameLabel = nil;
	self.profilePictureView = nil;
	self.loginButton = nil;
	self.proceedButton = nil;
	
	[super dealloc];
}

#pragma mark -
#pragma mark Public

- (void)fillWithUser:(id<FBGraphUser>)user {
	self.loggedInLabel.text = kFFLoggedInMessage;
	self.usernameLabel.text = user.name;
	self.profilePictureView.profileID = user.id;
	
	self.proceedButton.enabled = YES;
	self.proceedButton.alpha = 1;
}

- (void)clearUser {
	self.loggedInLabel.text = kFFNotLoggedInMessage;
	self.usernameLabel.text = @"";
	self.profilePictureView.profileID = nil;
	
	self.proceedButton.enabled = NO;
	self.proceedButton.alpha = 0.5;
}

@end
