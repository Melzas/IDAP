#import <Foundation/Foundation.h>

#import "IDPObservable.h"

@interface IDPObservableWrapper : NSObject
@property (nonatomic, assign)	id<IDPObservable>	observable;

@end
