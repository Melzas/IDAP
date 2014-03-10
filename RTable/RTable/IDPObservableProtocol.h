#import <Foundation/Foundation.h>

@protocol IDPObserver;

@protocol IDPObservableObject <NSObject>

@optional

- (void)addObserver:(id<IDPObserver>)observer;
- (void)removeObserver:(id<IDPObserver>)observer;
- (void)notifyObserversWithObservableObject:(id<IDPObservableObject>)observableObject;

- (NSArray *)observers;

@end
