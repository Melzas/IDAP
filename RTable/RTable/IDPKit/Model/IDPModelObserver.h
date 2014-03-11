#import <Foundation/Foundation.h>

@protocol IDPModelObserver <NSObject>

- (void)modelWillLoad:(id)model;
- (void)modelDidLoad:(id)model;
- (void)modelDidUnload:(id)model;

@end
