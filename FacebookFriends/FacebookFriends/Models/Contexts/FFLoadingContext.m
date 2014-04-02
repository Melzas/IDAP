//
//  FFLoadingContext.m
//  FacebookFriends
//
//  Created by Anton Rayev on 4/2/14.
//  Copyright (c) 2014 Anton Rayev. All rights reserved.
//

#import "FFLoadingContext.h"

@interface FFLoadingContext ()
@property (nonatomic, retain)	FBRequestConnection *requestConnection;

@end

@implementation FFLoadingContext

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)cleanup {
	self.requestConnection = nil;
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
	[self.requestConnection cancel];
	
	[super cancel];
}

- (void)loadFromFacebookWithGraphPath:(NSString *)graphPath {
	self.requestConnection = [FBRequestConnection object];
	
	__block FFLoadingContext *weakSelf = self;
	
	FBRequestHandler handler = ^(FBRequestConnection *connection, id result, NSError *error) {
		[weakSelf loadingDidFinishWithResult:result error:error];
		
		weakSelf.requestConnection = nil;
	};
	
	FBRequestConnection *requestConnection = self.requestConnection;
	FBRequest *request = [FBRequest requestForGraphPath:graphPath];
	
	[requestConnection addRequest:request completionHandler:handler];
	[requestConnection start];
}

#pragma mark -
#pragma mark Private

- (void)loadingDidFinishWithResult:(id)result error:(NSError *)error {
	
}

@end
