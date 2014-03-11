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
		[self notifyObserversOfModelDidLoad];
		return NO;
	}
	
	if (kIDPModelLoading == self.state) {
		return NO;
	}
	
	[self prepareForLoad];
	self.state = kIDPModelLoading;
	[self notifyObserversOfModelWillLoad];
	[self performLoading];
	
	return YES;
}

- (void)dump {
    if (kIDPModelUnloaded == self.state || kIDPModelNotLoaded == self.state) {
        return;
    }
    
    self.state = kIDPModelUnloaded;
    [self cleanup];
    [self notifyObserversOfModelDidUnload];
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
	self.state = kIDPModelLoaded;
	[self notifyObserversOfModelDidLoad];
}

- (void)notifyObserversOfModelWillLoad {
	[self notifyObserversOnMainThreadWithSelector:@selector(modelWillLoad:)];
}

- (void)notifyObserversOfModelDidLoad {
	[self notifyObserversOnMainThreadWithSelector:@selector(modelDidLoad:)];
}

- (void)notifyObserversOfModelDidUnload {
	[self notifyObserversOnMainThreadWithSelector:@selector(modelDidUnload:)];
}

@end
