//
//  FFDatabaseUsersContext.m
//  FacebookFriends
//
//  Created by Anton Rayev on 4/15/14.
//  Copyright (c) 2014 Anton Rayev. All rights reserved.
//

#import "FFDatabaseUsersContext.h"

#import "FFUsers.h"
#import "FFUser.h"

@implementation FFDatabaseUsersContext

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)cleanup {
	self.users = nil;
}

#pragma mark -
#pragma mark Public

- (void)performLoading {
	NSString *sortKey = NSStringFromSelector(@selector(profileID));
	NSSortDescriptor *sortDescriptor = [[[NSSortDescriptor alloc] initWithKey:sortKey
																	ascending:YES] autorelease];
	
	NSArray *users = [FFUser fetchEntityWithSortDescriptors:@[sortDescriptor]
												  predicate:nil
											  prefetchPaths:nil];
	if (0 == [users count]) {
		[self failLoading];
		return;
	}
	
	FFUsers *usersData = self.users;
	
	for (FFUser *user in users) {
		[usersData addUser:user];
		[user finishLoading];
	}
	
	[self finishLoading];
	[usersData finishLoading];
}

@end
