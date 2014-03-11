#import <Foundation/Foundation.h>

#import "IDPObservableProtocol.h"

@protocol IDPObserver <NSObject>

@optional

- (void)addObservableObject:(id<IDPObservableObject>)observableObject;
- (void)removeObservableObject:(id<IDPObservableObject>)observableObject;

- (NSArray *)observableObjects;

@end
