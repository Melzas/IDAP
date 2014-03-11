#import "RTTableModel.h"

#import "RTCellModel.h"

static NSString * const kRTStorageFileName	= @"RTStorageFileName.plist";
static const NSUInteger kRTCellModelCount	= 10;

@interface RTTableModel ()
@property (nonatomic, retain)	NSMutableArray	*mutableCellModels;
@property (nonatomic, readonly)	NSString		*savePath;

- (void)generateModels;

@end

@implementation RTTableModel

@dynamic cellModels;

#pragma mark -
#pragma mark Accessors

- (NSArray *)cellModels {
	return [[self.mutableCellModels copy] autorelease];
}

- (NSString *)savePath {
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *savePath = paths[0];
    
    return [savePath stringByAppendingPathComponent:kRTStorageFileName];
}

#pragma mark -
#pragma mark Public

- (void)addCellModel:(RTCellModel *)cellModel {
	[self.mutableCellModels addObject:cellModel];
}

- (void)removeCellModel:(RTCellModel *)cellModel {
	[self.mutableCellModels removeObject:cellModel];
}

- (void)moveCellModelFromIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex {
	NSMutableArray *cellModels = self.mutableCellModels;
	
	NSString *cellModelToMove = [[cellModels[fromIndex] retain] autorelease];
	[cellModels removeObject:cellModelToMove];
	[cellModels insertObject:cellModelToMove atIndex:toIndex];
}

- (void)save {
	[NSKeyedArchiver archiveRootObject:self.mutableCellModels toFile:self.savePath];
}

- (void)prepareForLoad {
	self.mutableCellModels = [NSMutableArray array];
}

- (void)performLoading {
	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
		sleep(2);
		
		NSArray *modelsFromFile = [NSKeyedUnarchiver unarchiveObjectWithFile:self.savePath];
		if (modelsFromFile) {
			self.mutableCellModels = [NSMutableArray arrayWithArray:modelsFromFile];
		} else {
			[self generateModels];
		}
		
		[self finishLoading];
	});
}

- (void)cleanup {
	[self save];
	
	self.mutableCellModels = nil;
}

#pragma mark -
#pragma mark Private

- (void)generateModels {
	for (NSUInteger i = 0; i < kRTCellModelCount; ++i) {
		[self addCellModel:[RTCellModel model]];
	}
}

@end
