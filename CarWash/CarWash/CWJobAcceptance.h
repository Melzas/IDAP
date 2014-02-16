#import <Foundation/Foundation.h>

@class CWWorker;

@protocol CWJobAcceptance <NSObject>

- (void)jobCompletedByWorker:(CWWorker *)worker;

@end
