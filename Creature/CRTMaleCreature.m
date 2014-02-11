//
//  CRTMaleCreature.m
//  Creature
//
//  Created by Anton on 12.02.14.
//  Copyright (c) 2014 Anton Rayev. All rights reserved.
//

#import "CRTMaleCreature.h"

@implementation CRTMaleCreature

#pragma mark -
#pragma mark Public

- (void)wageWar {
    NSLog(@"%@(%lu) wages a war\n\n", self.name, self.age);
}

- (void)performGenderSpecificOperation {
	[self wageWar];
}

@end
