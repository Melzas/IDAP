#import <UIKit/UIKit.h>

@class RTStringViewController;

@interface RTAppDelegate : UIResponder <UIApplicationDelegate>
@property (nonatomic, retain)	UIWindow				*window;
@property (nonatomic, readonly) RTStringViewController	*stringViewController;

@end
