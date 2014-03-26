//
//  FFLoginView.m
//  FacebookFriends
//
//  Created by Anton Rayev on 3/26/14.
//  Copyright (c) 2014 Anton Rayev. All rights reserved.
//

#import "FFLoginView.h"

@implementation FFLoginView

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
	self.usernameLabel = nil;
	self.profilePictureView = nil;
	self.loginView = nil;
	
	[super dealloc];
}

@end
