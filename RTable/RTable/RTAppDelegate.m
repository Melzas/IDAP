#import "RTAppDelegate.h"

#import "NSObject+IDPExtensions.h"
#import "RTStringViewController.h"
#import "RTTableModel.h"

@implementation RTAppDelegate

@dynamic stringViewController;

#pragma mark -
#pragma mark Accessors

- (RTStringViewController *)stringViewController {
	if ([self.window.rootViewController isKindOfClass:[RTStringViewController class]]) {
		return (RTStringViewController *)self.window.rootViewController;
	}
	
	return nil;
}

#pragma mark -
#pragma mark UIApplicationDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    self.window.backgroundColor = [UIColor whiteColor];
	
	RTStringViewController *stringViewController = [RTStringViewController object];
	self.window.rootViewController = stringViewController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {

}

- (void)applicationDidEnterBackground:(UIApplication *)application {
	[self.stringViewController.stringStorage saveToFile];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {

}

- (void)applicationDidBecomeActive:(UIApplication *)application {

}

- (void)applicationWillTerminate:(UIApplication *)application {

}

@end
