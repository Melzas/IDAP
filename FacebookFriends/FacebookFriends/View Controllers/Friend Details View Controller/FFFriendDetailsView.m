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

@interface FFFriendDetailsView ()

- (void)fillFromModel:(FFUserData *)userData;

@end

@implementation FFFriendDetailsView

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
	self.friendImageView = nil;
	self.firstNameLabel = nil;
	self.lastNameLabel = nil;
	self.locationLabel = nil;
	self.userData = nil;
	
	[super dealloc];
}

#pragma mark -
#pragma mark Accessors

- (void)setUserData:(FFUserData *)userData {
	IDPNonatomicRetainPropertySynthesizeWithObserver(_userData, userData);
	
	[userData load];
}

#pragma mark -
#pragma mark Private

- (void)fillFromModel:(FFUserData *)userData {
	self.friendImageView.model = userData.photo;
	self.firstNameLabel.text = userData.firstName;
	self.lastNameLabel.text = userData.lastName;
	self.locationLabel.text = userData.address;
}

#pragma mark -
#pragma mark IDPModelObserver

- (void)modelDidLoad:(id)model {
	[self fillFromModel:model];
}

@end
