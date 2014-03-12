#import "NSBundle+IDPExtensions.h"

@implementation NSBundle (IDPExtensions)

- (id)loadClass:(Class)class {
	return [self loadClass:class owner:nil];
}

- (id)loadClass:(Class)class
		  owner:(id)owner
{
	return [self loadClass:class owner:owner options:nil];
}

- (id)loadClass:(Class)class
		  owner:(id)owner
		options:(NSDictionary *)options
{
	return [self loadClass:class owner:owner options:options nibName:NSStringFromClass(class)];
}

- (id)loadClass:(Class)class
		  owner:(id)owner
		options:(NSDictionary *)options
		nibName:(NSString *)nibName
{
	NSArray *nibObjects = [self loadNibNamed:nibName owner:owner options:options];
	
	for(id<NSObject> object in nibObjects) {
		if ([object isMemberOfClass:class]) {
			return [[object retain] autorelease];
		}
	}
	
	return nil;
}

@end
