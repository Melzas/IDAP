#import <Foundation/Foundation.h>

@protocol IDPObservableObject <NSObject>

@optional
- (void)addObserver:(id)observer;
- (void)removeObserver:(id)observer;
- (NSArray *)observers;

- (void)notifyObserversOnMainThreadWithSelector:(SEL)selector;
- (void)notifyObserversOnMainThreadWithSelector:(SEL)selector object:(id)object;

@end
