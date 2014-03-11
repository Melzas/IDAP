#import "RTCellView.h"

#import "IDPObserver.h"

#import "RTCellModel.h"

@interface RTCellView ()
@property (nonatomic, retain)	IDPObserver	*observer;

- (void)fillFromModel:(RTCellModel *)cellModel;

@end

@implementation RTCellView

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)delete:(id)sender {
	self.observer = nil;
	
	[super dealloc];
}


#pragma mark -
#pragma mark Accessors

- (NSString *)restorationIdentifier {
	return NSStringFromClass([self class]);
}

#pragma mark -
#pragma mark Public

- (void)fillFromModel:(RTCellModel *)cellModel {
	self.imageView.image = cellModel.image;
	self.textLabel.text = cellModel.string;
}

#pragma mark -
#pragma mark IDPObserver

- (void)addObservableObject:(id<IDPObservableObject>)observableObject {
	[self.spinner startAnimating];
	[self.observer addObservableObject:observableObject];
}

- (void)removeObservableObject:(id<IDPObservableObject>)observableObject {
	[self.observer removeObservableObject:observableObject];
}

#pragma mark -
#pragma mark IDPModelObserver

- (void)modelDidLoad:(id)model {
	[self fillFromModel:model];
	[self.spinner stopAnimating];
}

@end
