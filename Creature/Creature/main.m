//
//  main.m
//  Creature
//
//  Created by Anton Rayev on 2/11/14.
//  Copyright (c) 2014 Anton Rayev. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CRTMaleCreature.h"
#import "CRTFemaleCreature.h"

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        CRTCreature *bigDaddy = [CRTMaleCreature creatureWithName:@"BigDaddy" age:62];
		CRTCreature *anna = [CRTFemaleCreature creatureWithName:@"Anna" age:22];
		CRTCreature *richard = [CRTMaleCreature creatureWithName:@"Richard" age:56];
		CRTCreature *sasha = [CRTFemaleCreature creatureWithName:@"Sasha" age:27];
		
		NSArray *creatures = @[bigDaddy, anna, richard, sasha];
		for (CRTCreature *creature in creatures) {
			[creature performGenderSpecificOperation];
		}
    }
    return 0;
}

