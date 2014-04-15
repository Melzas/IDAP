//
//  FFLoadingContext.m
//  FacebookFriends
//
//  Created by Anton Rayev on 4/2/14.
//  Copyright (c) 2014 Anton Rayev. All rights reserved.
//

#import "FFFacebookContext.h"

@interface FFFacebookContext ()
@property (nonatomic, retain)	FBRequestConnection *requestConnection;

@end

@implementation FFFacebookContext

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
	self.requestConnection = nil;
	
	[super cancel];
}

- (void)loadWithGraphPath:(NSString *)graphPath {
	dispatch_async(dispatch_get_main_queue(), ^{
		self.requestConnection = [FBRequestConnection object];
		
		__block FFFacebookContext *weakSelf = self;
		
		FBRequestHandler handler = ^(FBRequestConnection *connection, id result, NSError *error) {
			[weakSelf loadingDidFinishWithResult:result error:error];
			
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

- (void)loadingDidFinishWithResult:(id)result error:(NSError *)error {
	
}

@end
