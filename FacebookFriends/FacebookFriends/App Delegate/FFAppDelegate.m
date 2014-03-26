//
//  FFAppDelegate.m
//  FacebookFriends
//
//  Created by Anton Rayev on 3/17/14.
//  Copyright (c) 2014 Anton Rayev. All rights reserved.
//

#import "FFAppDelegate.h"

#import "FFUsersData.h"

#import "FFFriendsViewController.h"

@implementation FFAppDelegate

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
	self.window = nil;
	self.users = nil;
	
	[super dealloc];
}

#pragma mark -
#pragma mark UIApplicationDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    self.window.backgroundColor = [UIColor whiteColor];
	
	FFFriendsViewController *friendsViewController = [FFFriendsViewController defaultNibController];
	self.users = [FFUsersData object];
	friendsViewController.usersData = self.users;
	self.window.rootViewController = friendsViewController;
	
    [self.window makeKeyAndVisible];
	
    return YES;
}

- (BOOL)application:(UIApplication *)application
			openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
		 annotation:(id)annotation
{
	return [FBAppCall handleOpenURL:url sourceApplication:sourceApplication];
}

- (void)applicationWillResignActive:(UIApplication *)application {

}

- (void)applicationDidEnterBackground:(UIApplication *)application {
	[self.users save];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {

}

- (void)applicationDidBecomeActive:(UIApplication *)application {

}

- (void)applicationWillTerminate:(UIApplication *)application {
	[self.users save];
}

@end
