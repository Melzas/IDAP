#import <Foundation/Foundation.h>

@class RTCellModel;

typedef enum {
	kRTTableModelNotLoaded,
	kRTTableModelLoading,
	kRTTableModelLoaded
} RTTableModelLoadState;

@interface RTTableModel : NSObject
@property (nonatomic, readonly)	NSArray					*cellModels;
@property (nonatomic, readonly)	RTTableModelLoadState	loadState;

- (void)addCellModel:(RTCellModel *)cellModel;
- (void)removeCellModel:(RTCellModel *)cellModel;
- (void)moveCellModelFromIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex;

- (void)load;
- (void)save;
- (void)dump;

@end
