#import <Foundation/Foundation.h>

#import "IDPObservableProtocol.h"

// Holds weak links to its observers. If your observer doesn't inherit IDPObserver class,
// you need to remove an observer manually with selector removeObserver:
@interface IDPObservableObject : NSObject <IDPObservableObject>

+ (instancetype)observableObject;

@end
