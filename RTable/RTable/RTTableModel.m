#import "RTTableModel.h"

#import "RTCellModel.h"

static NSString * const kRTStorageFileName	= @"RTStorageFileName.plist";
static const NSUInteger kRTCellModelCount	= 10;

@interface RTTableModel ()
@property (nonatomic, retain)	NSMutableArray	*mutableCellModels;
@property (nonatomic, readonly)	NSString		*savePath;
@property (nonatomic, assign, readwrite)		BOOL	loaded;

- (void)generateModels;

@end

@implementation RTTableModel

@dynamic cellModels;

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
	self.mutableCellModels = nil;
	
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    if (self) {
		self.mutableCellModels = [NSMutableArray array];
    }
	
    return self;
}

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

- (void)load {
	NSArray *modelsFromFile = [NSArray arrayWithContentsOfFile:self.savePath];
	if (modelsFromFile) {
		self.mutableCellModels = [NSMutableArray arrayWithArray:modelsFromFile];
	} else {
		[self generateModels];
	}
	
	self.loaded = YES;
}

- (void)save {
	[self.mutableCellModels writeToFile:self.savePath atomically:YES];
}

- (void)dump {
	[self save];
	
	self.mutableCellModels = [NSMutableArray array];
}

#pragma mark -
#pragma mark Private

- (void)generateModels {
	for (NSUInteger i = 0; i < kRTCellModelCount; ++i) {
		[self addCellModel:[RTCellModel model]];
	}
}

@end
