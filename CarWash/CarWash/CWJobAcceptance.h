#import <Foundation/Foundation.h>

#import "IDPObserver.h"

@class CWWorker;

@protocol CWJobAcceptance <IDPObserver>

- (void)jobCompletedByWorker:(CWWorker *)worker;

@end
