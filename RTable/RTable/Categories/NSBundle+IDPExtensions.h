#import <Foundation/Foundation.h>

@interface NSBundle (IDPExtensions)

- (id)loadClass:(Class)class;

- (id)loadClass:(Class)class
		  owner:(id)owner;

- (id)loadClass:(Class)class
		  owner:(id)owner
		options:(NSDictionary *)options;

- (id)loadClass:(Class)class
		  owner:(id)owner
		options:(NSDictionary *)options
		nibName:(NSString *)nibName;

@end
