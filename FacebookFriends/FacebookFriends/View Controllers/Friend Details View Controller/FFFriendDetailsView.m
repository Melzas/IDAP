//
//  FFFriendDetailsView.m
//  FacebookFriends
//
//  Created by Anton Rayev on 3/27/14.
//  Copyright (c) 2014 Anton Rayev. All rights reserved.
//

#import "FFFriendDetailsView.h"

#import "FFUser.h"

#import "FFImageView.h"

@implementation FFFriendDetailsView

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
	self.friendImageView = nil;
	self.firstNameLabel = nil;
	self.lastNameLabel = nil;
	self.locationLabel = nil;
	
	[super dealloc];
}

#pragma mark -
#pragma mark Private

- (void)fillFromModel:(FFUser *)user {
	self.friendImageView.model = user.photo;
	self.firstNameLabel.text = user.firstName;
	self.lastNameLabel.text = user.lastName;
	self.locationLabel.text = user.address;
}

@end
