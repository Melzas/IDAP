#import <Foundation/Foundation.h>

#import "IDPObservableProtocol.h"

@interface IDPObservableWrapper : NSObject
@property (nonatomic, readonly)	id<IDPObservable>	observable;

+ (instancetype)wrapperWithObservable:(id<IDPObservable>)observable;
- (instancetype)initWithObservable:(id<IDPObservable>)observable;

@end
