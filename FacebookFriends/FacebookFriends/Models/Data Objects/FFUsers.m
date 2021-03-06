//
//  FFUsersData.m
//  FacebookFriends
//
//  Created by Anton Rayev on 3/20/14.
//  Copyright (c) 2014 Anton Rayev. All rights reserved.
//

#import "FFUsers.h"

#import "FFUser.h"

@interface FFUsers ()
@property (nonatomic, retain)	NSMutableArray	*mutableUsers;

@end

@implementation FFUsers

@dynamic models;

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)cleanup {
	self.mutableUsers = nil;
}

- (id)init {
    self = [super init];
    if (self) {
        self.mutableUsers = [NSMutableArray array];
    }
	
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSArray *)models {
	return [[self.mutableUsers copy] autorelease];
}

#pragma mark -
#pragma mark Public

- (void)addUser:(FFUser *)user {
	@synchronized(self) {
		[self.mutableUsers addObject:user];
	}
}

- (void)removeUser:(FFUser *)user {
	@synchronized(self) {
		[self.mutableUsers removeObject:user];
	}
}

@end
