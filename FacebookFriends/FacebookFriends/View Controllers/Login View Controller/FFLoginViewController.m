//
//  FFLoginViewController.m
//  FacebookFriends
//
//  Created by Anton Rayev on 3/26/14.
//  Copyright (c) 2014 Anton Rayev. All rights reserved.
//

#import "FFLoginViewController.h"

#import "FFLoginView.h"

#import "FFFriendsViewController.h"

static NSString * const kFFPublishPermissions[] = {
	@"basic_info",
	@"friends_hometown",
	@"friends_location"
};
static const NSUInteger kFFPublishPermissionsSize = sizeof(kFFPublishPermissions)
	/ sizeof(NSString *);

@interface FFLoginViewController ()
@property (nonatomic, readonly)	FFLoginView	*loginView;

@end


@implementation FFLoginViewController

@dynamic loginView;

#pragma mark -
#pragma mark View Lifecycle

- (void)awakeFromNib {
	NSArray *publishPermissions = [NSArray arrayWithObjects:kFFPublishPermissions
													  count:kFFPublishPermissionsSize];
	
	self.loginView.loginButton.publishPermissions = publishPermissions;
	
	[super awakeFromNib];
}

#pragma mark -
#pragma mark Accessors

IDPViewControllerViewOfClassGetterSynthesize(FFLoginView, loginView);

#pragma mark -
#pragma mark Interface Handling

- (IBAction)onProceed:(id)sender {
	FFFriendsViewController *friendsViewController = [FFFriendsViewController defaultNibController];
	[self.navigationController pushViewController:friendsViewController animated:YES];
}

#pragma mark -
#pragma mark FBLoginViewDelegate

- (void)loginViewShowingLoggedInUser:(FBLoginView *)loginView {
	self.loginView.proceedButton.enabled = YES;
}

- (void)loginViewFetchedUserInfo:(FBLoginView *)fbLoginView user:(id<FBGraphUser>)user {
	[self.loginView fillWithUser:user];
}

- (void)loginViewShowingLoggedOutUser:(FBLoginView *)fbLoginView {
	[self.loginView clearUser];
}

@end
