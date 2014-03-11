#import <Foundation/Foundation.h>

#import "IDPObserver.h"

@protocol IDPModelObserver <IDPObserver>

@optional
- (void)modelWillLoad:(id)model;
- (void)modelDidLoad:(id)model;
- (void)modelDidUnload:(id)model;

@end
