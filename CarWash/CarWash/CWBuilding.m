#import "CWBuilding.h"

#import "CWRoom.h"

@interface CWBuilding ()
@property (nonatomic, retain)	NSMutableArray	*mutableRooms;

@end

@implementation CWBuilding

@dynamic rooms;

#pragma mark -
#pragma mark Class Methods

+ (instancetype)building {
	return [[[self alloc] init] autorelease];
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
	self.mutableRooms = nil;
	
	[super dealloc];
}

- (id)init {
	if (self = [super init]) {
		self.mutableRooms = [NSMutableArray array];
	}
	return self;
}

#pragma mark -
#pragma mark Accessors

- (NSArray *)rooms {
	return [[self.mutableRooms copy] autorelease];
}

#pragma mark -
#pragma mark Public

- (void)addRoom:(CWRoom *)room {
	[self.mutableRooms addObject:room];
}

- (void)removeRoom:(CWRoom *)room {
	[self.mutableRooms removeObjectIdenticalTo:room];
}

@end
