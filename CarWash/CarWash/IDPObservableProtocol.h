#import <Foundation/Foundation.h>

@protocol IDPObserver;

@protocol IDPObservable <NSObject>

- (void)addObserver:(id<IDPObserver>)observer;
- (void)removeObserver:(id<IDPObserver>)observer;
- (void)notifyObserversWithObservable:(id<IDPObservable>)observable;

- (NSArray *)observers;

@end
