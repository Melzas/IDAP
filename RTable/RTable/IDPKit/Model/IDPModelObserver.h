#import <Foundation/Foundation.h>

@protocol IDPModelObserver <NSObject>

@optional
- (void)modelWillLoad:(id)model;
- (void)modelDidLoad:(id)model;
- (void)modelDidUnload:(id)model;

@end
