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

static NSString * const kFFReadPermissions[] = {
	@"basic_info",
	@"friends_hometown",
	@"friends_location"
};
static const NSUInteger kFFReadPermissionsSize = sizeof(kFFReadPermissions)
	/ sizeof(NSString *);

@interface FFLoginViewController ()
@property (nonatomic, readonly)	FFLoginView	*loginView;

@end


@implementation FFLoginViewController

@dynamic loginView;

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
	self.friendsViewController = nil;
	
	[super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		self.friendsViewController = [FFFriendsViewController defaultNibController];
    }
	
    return self;
}

#pragma mark -
#pragma mark View Lifecycle

- (void)viewDidLoad {
	NSArray *readPermissions = [NSArray arrayWithObjects:kFFReadPermissions
												   count:kFFReadPermissionsSize];
	
	self.loginView.loginButton.readPermissions = readPermissions;
	
	[super viewDidLoad];
}

#pragma mark -
#pragma mark Accessors

IDPViewControllerViewOfClassGetterSynthesize(FFLoginView, loginView);

#pragma mark -
#pragma mark Interface Handling

- (IBAction)onProceed:(id)sender {
	[self.navigationController pushViewController:self.friendsViewController animated:YES];
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
