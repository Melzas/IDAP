#import "IDPModel.h"

#import "IDPModelObserver.h"

@interface IDPModel ()
@property (atomic, assign) IDPModelState   state;

@end

@implementation IDPModel

- (void)dealloc {
	[self cleanup];
	
	[super dealloc];
}

#pragma mark -
#pragma mark Public

- (BOOL)load {
	if (kIDPModelLoaded == self.state) {
		[self notifyObserversOflDidLoad];
		return NO;
	}
	
	if (kIDPModelLoading == self.state) {
		return NO;
	}
	
	[self prepareForLoad];
	self.state = kIDPModelLoading;
	[self notifyObserversOfWillLoad];
	[self performLoading];
	
	return YES;
}

- (void)dump {
    if (kIDPModelUnloaded == self.state || kIDPModelNotLoaded == self.state) {
        return;
    }
    
    self.state = kIDPModelUnloaded;
    [self cleanup];
    [self notifyObserversOfDidUnload];
}

- (void)cleanup {
	
}

#pragma mark -
#pragma mark Private

- (void)prepareForLoad {
	
}

- (void)performLoading {
	
}

- (void)finishLoading {
	dispatch_async(dispatch_get_main_queue(), ^{
		self.state = kIDPModelLoaded;
		[self notifyObserversOflDidLoad];
	});
}

- (void)notifyObserversOfWillLoad {
	[self notifyObserversOnMainThreadWithSelector:@selector(modelWillLoad:)];
}

- (void)notifyObserversOflDidLoad {
	[self notifyObserversOnMainThreadWithSelector:@selector(modelDidLoad:)];
}

- (void)notifyObserversOfDidUnload {
	[self notifyObserversOnMainThreadWithSelector:@selector(modelDidUnload:)];
}

@end
