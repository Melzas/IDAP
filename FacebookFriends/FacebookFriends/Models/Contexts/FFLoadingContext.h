//
//  FFLoadingContext.h
//  FacebookFriends
//
//  Created by Anton Rayev on 4/2/14.
//  Copyright (c) 2014 Anton Rayev. All rights reserved.
//

@interface FFLoadingContext : IDPModel
@property (nonatomic, readonly)	FBRequestConnection *requestConnection;

- (void)loadFromFacebookWithGraphPath:(NSString *)graphPath;

// intended for subclassing
// never call this method directly
// called when loading from facebook is finished
- (void)loadingDidFinishWithResult:(id)result error:(NSError *)error;

@end
