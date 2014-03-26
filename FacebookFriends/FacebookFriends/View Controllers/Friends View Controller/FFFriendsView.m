//
//  FFMainView.m
//  FacebookFriends
//
//  Created by Anton Rayev on 3/17/14.
//  Copyright (c) 2014 Anton Rayev. All rights reserved.
//

#import "FFFriendsView.h"

@implementation FFFriendsView

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
	self.tableView = nil;
	
	[super dealloc];
}

@end
