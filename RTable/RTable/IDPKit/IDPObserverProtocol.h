#import <Foundation/Foundation.h>

#import "IDPObservableProtocol.h"

@protocol IDPObserver <NSObject>

- (void)didReceiveNotificationFromObservableObject:(id<IDPObservableObject>)observableObject;

@optional

- (void)addObservableObject:(id<IDPObservableObject>)observableObject;
- (void)removeObservableObject:(id<IDPObservableObject>)observableObject;

- (NSArray *)observableObjects;

@end
