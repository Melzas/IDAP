#import <Foundation/Foundation.h>

#import "IDPObservableProtocol.h"

@interface IDPObservableObject : NSObject <IDPObservableObject>

+ (instancetype)observableObject;

@end
