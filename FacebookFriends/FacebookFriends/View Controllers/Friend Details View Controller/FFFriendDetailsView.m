//
//  FFFriendDetailsView.m
//  FacebookFriends
//
//  Created by Anton Rayev on 3/27/14.
//  Copyright (c) 2014 Anton Rayev. All rights reserved.
//

#import "FFFriendDetailsView.h"

#import "FFUserData.h"

#import "FFFriendImageView.h"

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

- (void)fillFromModel:(FFUserData *)userData {
	self.friendImageView.model = userData.photo;
	self.firstNameLabel.text = userData.firstName;
	self.lastNameLabel.text = userData.lastName;
	self.locationLabel.text = userData.address;
}

@end
