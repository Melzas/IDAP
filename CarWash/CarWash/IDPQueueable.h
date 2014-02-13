#import <Foundation/Foundation.h>

@protocol IDPQueueable <NSObject>

- (void)setInQueue:(BOOL)inQueue;
- (BOOL)isInQueue;

@end
