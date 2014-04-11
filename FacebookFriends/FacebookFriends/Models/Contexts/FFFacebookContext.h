//
//  FFLoadingContext.h
//  FacebookFriends
//
//  Created by Anton Rayev on 4/2/14.
//  Copyright (c) 2014 Anton Rayev. All rights reserved.
//

@interface FFFacebookContext : IDPModel
@property (nonatomic, readonly)	FBRequestConnection *requestConnection;

- (void)loadWithGraphPath:(NSString *)graphPath;

// intended for subclassing
// never call this methods directly
// called when loading from facebook is finished or failed
- (void)loadingDidFinishWithResult:(id)result;
- (void)loadingDidFail;

@end
