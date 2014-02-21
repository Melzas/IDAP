#import <Foundation/Foundation.h>

#import "IDPObservableProtocol.h"

@protocol IDPObserver <NSObject>

- (void)addObservable:(id<IDPObservable>)observable;
- (void)removeObservable:(id<IDPObservable>)observable;
- (void)notify;

- (NSArray *)observables;

@end
