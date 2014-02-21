#import "IDPObservableWrapper.h"

@interface IDPObservableWrapper ()
@property (nonatomic, assign, readwrite)	id<IDPObservable>	observable;

@end

@implementation IDPObservableWrapper

+ (instancetype)wrapperWithObservable:(id<IDPObservable>)observable {
	return [[[self alloc] initWithObservable:observable] autorelease];
}

- (instancetype)initWithObservable:(id<IDPObservable>)observable {
	self = [super init];
    if (self) {
        self.observable = observable;
    }
    return self;
}

@end
