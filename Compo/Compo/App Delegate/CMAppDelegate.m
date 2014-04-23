//
//  CMAppDelegate.m
//  Compo
//
//  Created by Anton Rayev on 4/18/14.
//  Copyright (c) 2014 Anton Rayev. All rights reserved.
//

#import "CMAppDelegate.h"

static NSString * const kCMTabBarNibName = @"CMTabBarController";

@implementation CMAppDelegate

#pragma mark -
#pragma Initializations and Deallocations

- (void)dealloc {
	self.window = nil;
	
	[super dealloc];
}

#pragma mark -
#pragma mark UIApplicationDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	UIWindow *window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    window.backgroundColor = [UIColor whiteColor];
	
	window.rootViewController = [NSBundle loadClass:[UITabBarController class]
									   fromNibNamed:kCMTabBarNibName
											  owner:nil];
	
    [window makeKeyAndVisible];
	self.window = window;
	
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
	
}

- (void)applicationDidEnterBackground:(UIApplication *)application {

}

- (void)applicationWillEnterForeground:(UIApplication *)application {
}

- (void)applicationDidBecomeActive:(UIApplication *)application {

}

- (void)applicationWillTerminate:(UIApplication *)application {

}

@end
