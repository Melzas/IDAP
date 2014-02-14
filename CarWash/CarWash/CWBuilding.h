#import <Foundation/Foundation.h>

@interface CWBuilding : NSObject
@property (nonatomic, readonly)	NSArray	*rooms;

+ (instancetype)building;

- (void)addRoom:(id)room;

@end
