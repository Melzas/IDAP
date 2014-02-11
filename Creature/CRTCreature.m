//
//  CRTCreature.m
//  Creature
//
//  Created by Anton Rayev on 2/11/14.
//  Copyright (c) 2014 Anton Rayev. All rights reserved.
//

#import "CRTCreature.h"

@interface CRTCreature ()
@property (nonatomic, retain)	NSMutableArray  *mutableChildren;

@end

@implementation CRTCreature

@dynamic children;

#pragma mark -
#pragma mark Class Methods

+ (id)creatureWithName:(NSString *)name age:(NSUInteger)age {
    return [[[self alloc] initWithName:name age:age] autorelease];
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.mutableChildren = nil;
    self.name = nil;
    
    [super dealloc];
}

- (id)init {
	return [self initWithName:nil age:0];
}

- (id)initWithName:(NSString *)name age:(NSUInteger)age {
    self = [super init];
    if (self) {
        self.name = name;
        self.age = age;
        self.mutableChildren = [NSMutableArray array];
    }
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSArray *)children {
	return [[self.mutableChildren copy] autorelease];
}

- (NSComparisonResult)compare:(CRTCreature *)anotherCreature {
	return self.age - anotherCreature.age;
}

#pragma mark -
#pragma mark Public


- (void)addChild:(CRTCreature *)child {
    [self.mutableChildren addObject:child];
	[self.mutableChildren sortUsingSelector:@selector(compare:)];
}

- (void)sayPhrase:(NSString *)phrase {
    NSLog(@"%@(%lu) says: \"%@\"", self.name, self.age, phrase);
    for (CRTCreature *creature in self.mutableChildren) {
        [creature sayPhrase:phrase];
    }
}

- (void)performGenderSpecificOperation {
	
}

@end
