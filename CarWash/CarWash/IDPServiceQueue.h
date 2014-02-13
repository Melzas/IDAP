#import <Foundation/Foundation.h>

#import "IDPQueueable.h"

@interface IDPServiceQueue : NSObject <IDPQueueable>
@property (nonatomic, readonly)	NSArray	*queue;

@property (atomic, assign, getter = isBusy)		BOOL	busy;
@property (atomic, assign, getter = isInQueue)	BOOL	inQueue;

- (void)addObjectToQueue:(id<IDPQueueable>)object;
- (void)removeObjectFromQueue:(id<IDPQueueable>)object;
- (void)processNextObjectInQueue;

- (void)performInBackground:(id)object;
- (void)performOnMainThread:(id)object;

@end
