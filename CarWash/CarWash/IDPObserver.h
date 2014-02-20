#import <Foundation/Foundation.h>

#import "IDPObservable.h"

@protocol IDPObserver <NSObject>

- (void)addObservable:(id<IDPObservable>)observable;
- (void)removeObservable:(id<IDPObservable>)observable;

- (NSArray *)observables;

@end
