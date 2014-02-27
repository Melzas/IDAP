#import "IDPObservableObject.h"

typedef enum {
    kIDPModelNotLoaded,
    kIDPModelLoading,
    kIDPModelLoaded,
    kIDPModelUnloaded
} IDPModelState;

@interface IDPModel : IDPObservableObject
@property (nonatomic, readonly) IDPModelState   state;

// Loads the model into memory and inform observers of loading state.
// If the model is loaded already, notifies observers of successful load.
- (BOOL)load;

// Unloads the model from memory and inform observers of unloading state.
- (void)dump;

// Intended for subclassing. Should purge the model from memory.
// Called in dealloc and dump. Default implementation does nothing.
- (void)cleanup;

// Intended for subclassing. Should perform preparation steps before loading.
- (void)prepareForLoad;

// Intended for subclassing. Should load the model into memory.
- (void)performLoading;

// This method should be called manually after the model was loaded
// Notifies observers of successful loading and sets the corresponding state on main thread
- (void)finishLoading;

// These methods are private. You should never call them directly
- (void)notifyObserversOfWillLoad;
- (void)notifyObserversOflDidLoad;
- (void)notifyObserversOfDidUnload;

@end
