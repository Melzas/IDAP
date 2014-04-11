//
//  FFAppDelegate.m
//  FacebookFriends
//
//  Created by Anton Rayev on 3/17/14.
//  Copyright (c) 2014 Anton Rayev. All rights reserved.
//

#import "FFAppDelegate.h"

#import "FFUsers.h"

#import "FFLoginViewController.h"
#import "FFFriendsViewController.h"

static NSString * const kFFMomName = @"FacebookFriends";

@interface FFAppDelegate ()

@end

@implementation FFAppDelegate

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
	self.window = nil;
	
	[super dealloc];
}

#pragma mark -
#pragma mark UIApplicationDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    UIWindow *window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
	window.backgroundColor = [UIColor whiteColor];
	self.window = window;
	
	[IDPCoreDataManager sharedManagerWithMomName:kFFMomName];
	
	FFLoginViewController *loginViewController = [FFLoginViewController defaultNibController];
	
	UINavigationController *navigationController = [UINavigationController object];
	[navigationController pushViewController:loginViewController animated:NO];
	
	window.rootViewController = navigationController;
    [window makeKeyAndVisible];
	
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
	[NSManagedObjectContext saveManagedObjectContext];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {

}

- (void)applicationDidBecomeActive:(UIApplication *)application {

}

- (void)applicationWillTerminate:(UIApplication *)application {
	[NSManagedObjectContext saveManagedObjectContext];
}

@end
