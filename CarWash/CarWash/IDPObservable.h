#import <Foundation/Foundation.h>

#import "IDPObservableProtocol.h"

@interface IDPObservable : NSObject <IDPObservable>

+ (instancetype)observable;

@end
