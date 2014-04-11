//
//  FFLoadingContext.m
//  FacebookFriends
//
//  Created by Anton Rayev on 4/2/14.
//  Copyright (c) 2014 Anton Rayev. All rights reserved.
//

#import "FFFacebookContext.h"

#import "IDPNetworkReachability+FacebookReachability.h"

@interface FFFacebookContext ()
@property (nonatomic, retain)	FBRequestConnection		*requestConnection;
@property (nonatomic, retain)	IDPNetworkReachability	*networkReachability;

@end

@implementation FFFacebookContext

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)cleanup {
	self.requestConnection = nil;
	self.networkReachability = nil;
}

- (id)init {
    self = [super init];
    if (self) {
		self.networkReachability = [IDPNetworkReachability facebookReachabilty];
    }
    return self;
}

#pragma mark -
#pragma mark Accessors

- (void)setRequestConnection:(FBRequestConnection *)requestConnection {
	if (requestConnection != _requestConnection) {
		[_requestConnection cancel];
	}
	
	IDPNonatomicRetainPropertySynthesize(_requestConnection, requestConnection);
}

#pragma mark -
#pragma mark Public

- (void)cancel {
	self.requestConnection = nil;
	
	[super cancel];
}

- (void)loadWithGraphPath:(NSString *)graphPath {
	dispatch_async(dispatch_get_main_queue(), ^{
		if (!self.networkReachability.isReachable) {
			[self loadingDidFail];
			return;
		}
		
		self.requestConnection = [FBRequestConnection object];
		
		__block FFFacebookContext *weakSelf = self;
		
		FBRequestHandler handler = ^(FBRequestConnection *connection, id result, NSError *error) {
			if (nil != error) {
				[weakSelf loadingDidFail];
				return;
			}
			
			[weakSelf loadingDidFinishWithResult:result];
			weakSelf.requestConnection = nil;
		};
		
		FBRequestConnection *requestConnection = self.requestConnection;
		FBRequest *request = [FBRequest requestForGraphPath:graphPath];
		
		[requestConnection addRequest:request completionHandler:handler];
		[requestConnection start];
	});
}

#pragma mark -
#pragma mark Private

- (void)loadingDidFinishWithResult:(id)result {
	
}

- (void)loadingDidFail {
	
}

@end
