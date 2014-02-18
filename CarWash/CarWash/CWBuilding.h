#import <Foundation/Foundation.h>

@class CWRoom;

@interface CWBuilding : NSObject
@property (nonatomic, readonly)	NSArray	*rooms;

+ (instancetype)building;

- (void)addRoom:(CWRoom *)room;
- (void)removeRoom:(CWRoom *)room;

@end
