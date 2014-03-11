#import <Foundation/Foundation.h>

@interface IDPWeakReference : NSObject
@property (nonatomic, readonly)	id	object;

+ (instancetype)referenceWithObject:(id)object;
- (instancetype)initWithObject:(id)object;

@end
