//
//  CRTFemaleCreature.m
//  Creature
//
//  Created by Anton on 12.02.14.
//  Copyright (c) 2014 Anton Rayev. All rights reserved.
//

#import "NSObject+IDPExtensions.h"

#import "CRTFemaleCreature.h"
#import "CRTMaleCreature.h"

@interface CRTFemaleCreature ()

- (Class)classForGender:(CRTGender)gender;

@end


@implementation CRTFemaleCreature

#pragma mark -
#pragma mark Public

- (id)giveBirthToChildWithGender:(CRTGender)gender {
	id child = [[self classForGender:gender] object];
	NSLog(@"%@(%lu) gives a birth", self.name, self.age);
	NSLog(@"Baby is %@\n\n", [child class]);
	return child;
}

- (void)performGenderSpecificOperation {
	CRTGender childGender = ((arc4random() % 2) == 0) ? kCRTMale : kCRTFemale;
	[self addChild:[self giveBirthToChildWithGender:childGender]];
}

#pragma mark -
#pragma mark Private

- (Class)classForGender:(CRTGender)gender {
	if(kCRTMale == gender) {
		return [CRTMaleCreature class];
	} else {
		return [CRTFemaleCreature class];
	}
}

@end
