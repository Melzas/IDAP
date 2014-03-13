#import "RTAppDelegate.h"

#import "NSObject+IDPExtensions.h"
#import "RTMainViewController.h"
#import "RTTableModel.h"

@implementation RTAppDelegate

#pragma mark -
#pragma Initializations and Deallocations

- (void)dealloc {
	self.window = nil;
	self.tableModel = nil;
	
	[super dealloc];
}

#pragma mark -
#pragma mark UIApplicationDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	RTMainViewController *mainViewController = [RTMainViewController object];
	self.tableModel = [RTTableModel object];
	mainViewController.tableModel = self.tableModel;
	
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    self.window.backgroundColor = [UIColor whiteColor];
	self.window.rootViewController = mainViewController;
    [self.window makeKeyAndVisible];
	
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {

}

- (void)applicationDidEnterBackground:(UIApplication *)application {
	[self.tableModel save];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {

}

- (void)applicationDidBecomeActive:(UIApplication *)application {

}

- (void)applicationWillTerminate:(UIApplication *)application {
	[self.tableModel save];
}

@end
