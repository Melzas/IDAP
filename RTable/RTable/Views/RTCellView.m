#import "RTCellView.h"

#import "RTCellModel.h"

@interface RTCellView ()

- (void)fillFromModel:(RTCellModel *)cellModel;
- (void)loadModel;

@end

@implementation RTCellView

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
	self.spinner = nil;
	self.model = nil;
	
	[super dealloc];
}

#pragma mark -
#pragma mark Accessors

- (NSString *)restorationIdentifier {
	return NSStringFromClass([self class]);
}

- (void)setModel:(RTCellModel *)model {
	if (model != _model) {
		[_model removeObserver:self];
		[_model release];
		_model = [model retain];
		[_model addObserver:self];
		
		[self loadModel];
	}
}

#pragma mark -
#pragma mark Public

- (void)fillFromModel:(RTCellModel *)cellModel {
	self.imageView.image = cellModel.image;
	self.textLabel.text = cellModel.string;
}

#pragma mark -
#pragma mark Private

- (void)loadModel {
	[self.spinner startAnimating];
	
	[self.model load];
}

#pragma mark -
#pragma mark IDPModelObserver

- (void)modelDidLoad:(id)model {
	[self fillFromModel:model];
	
	[self.spinner stopAnimating];
}

@end
