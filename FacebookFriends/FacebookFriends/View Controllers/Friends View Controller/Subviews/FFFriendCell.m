#import "FFFriendCell.h"

#import "IDPPropertyMacros.h"

#import "FFImageModel.h"

#import "FFUser.h"

@interface FFFriendCell ()

- (void)fillFromModel:(FFUser *)user;

@end

@implementation FFFriendCell

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
	self.label = nil;
	self.pictureView = nil;
	self.user = nil;
	
	[super dealloc];
}

#pragma mark -
#pragma mark Accessors

- (NSString *)restorationIdentifier {
	return NSStringFromClass([self class]);
}

- (void)setUser:(FFUser *)user {
	IDPNonatomicRetainPropertySynthesizeWithObserver(_user, user);

	[user load];
}

#pragma mark -
#pragma mark Public

- (void)fillFromModel:(FFUser *)user {
	self.label.text = [NSString stringWithFormat:@"%@ %@", user.firstName, user.lastName];
	self.pictureView.model = user.photoPreview;
}

#pragma mark -
#pragma mark IDPModelObserver

- (void)modelDidLoad:(id)model {
	[self fillFromModel:model];
}

@end
