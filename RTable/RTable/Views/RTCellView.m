#import "RTCellView.h"

#import "IDPPropertyMacros.h"

#import "IDPImageModel.h"

#import "RTCellModel.h"

@interface RTCellView ()

- (void)fillFromModel:(RTCellModel *)cellModel;
- (void)loadModel;

@end

@implementation RTCellView

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
	self.label = nil;
	self.asyncImageView = nil;
	self.model = nil;
	
	[super dealloc];
}

#pragma mark -
#pragma mark Accessors

- (NSString *)restorationIdentifier {
	return NSStringFromClass([self class]);
}

- (void)setModel:(RTCellModel *)model {
	IDPNonatomicRetainPropertySynthesizeWithObserver(_model, model);

	[self loadModel];
}

#pragma mark -
#pragma mark Public

- (void)fillFromModel:(RTCellModel *)cellModel {
	self.label.text = cellModel.string;
	self.asyncImageView.model = cellModel.imageModel;
}

#pragma mark -
#pragma mark Private

- (void)loadModel {
	[self.model load];
}

#pragma mark -
#pragma mark IDPModelObserver

- (void)modelDidLoad:(id)model {
	[self fillFromModel:model];
}

@end
