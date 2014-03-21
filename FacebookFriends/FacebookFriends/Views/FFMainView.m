//
//  FFMainView.m
//  FacebookFriends
//
//  Created by Anton Rayev on 3/17/14.
//  Copyright (c) 2014 Anton Rayev. All rights reserved.
//

#import "FFMainView.h"

@implementation FFMainView

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
	self.loginView = nil;
	self.tableView = nil;
	
	[super dealloc];
}

@end
