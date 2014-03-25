//
//  FFUsersData.m
//  FacebookFriends
//
//  Created by Anton Rayev on 3/20/14.
//  Copyright (c) 2014 Anton Rayev. All rights reserved.
//

#import "FFUsersData.h"

#import "FFUsersData.h"

static NSString * const kFFStorageFileName = @"kFFStorageFileName.plist";

@interface FFUsersData ()
@property (nonatomic, retain)	NSMutableArray	*mutableUsers;

@end

@implementation FFUsersData

@dynamic users;
@dynamic savePath;

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)cleanup {
	[self save];
	
	self.mutableUsers = nil;
}

#pragma mark -
#pragma mark Accessors

- (NSArray *)users {
	return [[self.mutableUsers copy] autorelease];
}

- (NSString *)savePath {
	NSString *libraryDirectoryPath = [NSFileManager libraryDirectoryPath];
	NSString *cacheDirectoryPath = [libraryDirectoryPath stringByAppendingPathComponent:@"Caches"];
	return [cacheDirectoryPath stringByAppendingPathComponent:kFFStorageFileName];
}

#pragma mark -
#pragma mark Public

- (void)addUser:(FFUserData *)user {
	[self.mutableUsers addObject:user];
}

- (void)removeUser:(FFUserData *)user {
	[self.mutableUsers removeObject:user];
}

- (void)moveUserFromIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex {
	NSMutableArray *users = self.mutableUsers;
	
	FFUserData *userToMove = [[[users objectAtIndex:fromIndex] retain] autorelease];
	[users removeObjectAtIndex:fromIndex];
	[users insertObject:userToMove atIndex:toIndex];
}

#pragma mark -
#pragma mark Private

- (void)prepareForLoad {
	self.mutableUsers = [NSMutableArray array];
}

- (void)save {
	[NSKeyedArchiver archiveRootObject:self.mutableUsers toFile:self.savePath];
}

@end
