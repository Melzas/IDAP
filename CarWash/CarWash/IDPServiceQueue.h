#import <Foundation/Foundation.h>

@interface IDPServiceQueue : NSObject
@property (nonatomic, readonly)	NSArray	*queue;

@property (atomic, assign, getter = isBusy)	BOOL	busy;

- (void)addObjectToQueue:(id)object;
- (void)removeObjectFromQueue:(id)object;
- (void)processNextObjectInQueue;

- (void)performBackgroundTask:(id)object;
- (void)performMainThreadTask:(id)object;

@end
