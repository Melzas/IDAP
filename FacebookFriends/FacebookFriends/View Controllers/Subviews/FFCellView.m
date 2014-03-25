#import "FFCellView.h"

#import "IDPPropertyMacros.h"

#import "FFImageModel.h"

#import "FFUserData.h"

@interface FFCellView ()

- (void)fillFromModel:(FFUserData *)userData;
- (void)loadModel;

@end

@implementation FFCellView

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
	self.label = nil;
	self.pictureView = nil;
	self.userData = nil;
	
	[super dealloc];
}

#pragma mark -
#pragma mark Accessors

- (NSString *)restorationIdentifier {
	return NSStringFromClass([self class]);
}

- (void)setUserData:(FFUserData *)userData {
	IDPNonatomicRetainPropertySynthesizeWithObserver(_userData, userData);

	[self loadModel];
}

#pragma mark -
#pragma mark Public

- (void)fillFromModel:(FFUserData *)userData {
	self.label.text = [NSString stringWithFormat:@"%@ %@", userData.firstName, userData.lastName];
	self.pictureView.model = userData.photoPreview;
}

#pragma mark -
#pragma mark Private

- (void)loadModel {
	[self.userData load];
}

#pragma mark -
#pragma mark IDPModelObserver

- (void)modelDidLoad:(id)model {
	[self fillFromModel:model];
}

@end
