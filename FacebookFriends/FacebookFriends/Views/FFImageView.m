#import "FFImageView.h"

#import "NSBundle+IDPExtensions.h"

#import "IDPPropertyMacros.h"

#import "FFImageModel.h"

@interface FFImageView ()

- (void)loadModel;
- (void)fillFromModel:(FFImageModel *)model;

@end

@implementation FFImageView

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
	self.spinner = nil;
	self.imageView = nil;
	self.model = nil;
	
	[super dealloc];
}

#pragma mark -
#pragma mark Accessors

- (void)setModel:(FFImageModel *)imageModel {
	IDPNonatomicRetainPropertySynthesizeWithObserver(_model, imageModel);
	
	[self loadModel];
}

#pragma mark -
#pragma mark Private

- (void)loadModel {
	[self.spinner startAnimating];
	
	[self.model load];
}

- (void)fillFromModel:(FFImageModel *)model {
	self.imageView.image = model.image;
	[model save];
}

#pragma mark -
#pragma mark IDPModelObserver

- (void)modelDidLoad:(id)model {
	[self fillFromModel:model];
	
	[self.spinner stopAnimating];
	[self setNeedsDisplay];
}

- (void)modelDidFailToLoad:(id)theModel {
	[UIAlertView showInternetConnectionError];
}

@end
