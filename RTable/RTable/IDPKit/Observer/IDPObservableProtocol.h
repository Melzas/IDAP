#import <Foundation/Foundation.h>

@protocol IDPObserver;

@protocol IDPObservableObject <NSObject>

@optional

- (void)addObserver:(id<IDPObserver>)observer;
- (void)removeObserver:(id<IDPObserver>)observer;
- (NSArray *)observers;

- (void)notifyObserversOnMainThreadWithSelector:(SEL)selector;
- (void)notifyObserversOnMainThreadWithSelector:(SEL)selector object:(id)object;

@end
