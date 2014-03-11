#import <Foundation/Foundation.h>

#import "IDPModel.h"

@class RTCellModel;

@interface RTTableModel : IDPModel
@property (nonatomic, readonly)	NSArray	*cellModels;

- (void)addCellModel:(RTCellModel *)cellModel;
- (void)removeCellModel:(RTCellModel *)cellModel;
- (void)moveCellModelFromIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex;

- (void)save;

@end
