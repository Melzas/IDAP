//
//  CRTCreature.h
//  Creature
//
//  Created by Anton Rayev on 2/11/14.
//  Copyright (c) 2014 Anton Rayev. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {kCRTMale, kCRTFemale} CRTGender;

@interface CRTCreature : NSObject
@property (nonatomic, assign)	NSUInteger	age;
@property (nonatomic, copy)		NSString	*name;
@property (nonatomic, readonly)	NSArray		*children;

+ (id)creatureWithName:(NSString *)name age:(NSUInteger)age;
- (id)initWithName:(NSString *)name age:(NSUInteger)age;

- (void)addChild:(CRTCreature *)child;
- (void)sayPhrase:(NSString *)phrase;

- (void)performGenderSpecificOperation;

@end
