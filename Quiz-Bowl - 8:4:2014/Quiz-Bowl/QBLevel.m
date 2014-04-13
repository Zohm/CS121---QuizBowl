//
//  QBLevel.m
//  QuizbowlGame
//
//  Created by jarthurcs on 3/7/14.
//  Copyright (c) 2014 HMC_CS121. All rights reserved.
//

#import "QBLevel.h"

@implementation QBLevel
{
    NSInteger _currentTossUpIndex;
    NSInteger _currentBonusIndex;
}

+(instancetype)levelWithName:(NSString *)name
{
    //Find the .plist file associated with the file
    NSString* filename = [NSString stringWithFormat:@"%@.plist", name];
    NSString* levelPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:filename];
    
    //Load the .plist
    NSDictionary* levelDict = [NSDictionary dictionaryWithContentsOfFile:levelPath];
    
    //Make sure the file loaded correctly
    NSAssert(levelDict, @"level config file not found");
    
    //Create level instance
    QBLevel* l = [[QBLevel alloc] init];
    
    //Initialize data members from contents of dictionary
    NSMutableArray* tossups = [NSMutableArray array];
    NSArray* pairs = levelDict[@"Toss Up"];
    for (int i = 0; i < [pairs count]; ++i) {
        [tossups addObject:[[QBRound alloc] initWithPair:[pairs objectAtIndex:i]]];
    }
    
    NSMutableArray* bonus = [NSMutableArray array];
    NSArray* sets = levelDict[@"Bonus"];
    for (int i = 0; i < [sets count]; ++i) {
        NSArray* set = [sets objectAtIndex:i];
        [bonus addObject:[[QBRound alloc] initWithSet:set]];
    }
    
    l.tossups = tossups;
    l.bonus = bonus;
    
    return l;
}

-(instancetype)init
{
    self = [super init];
    if (self) {
        _currentBonusIndex = 0;
        _currentTossUpIndex = 0;
    }
    return self;
}

-(BOOL) hasNextTossUp
{
    return (_currentTossUpIndex < [self.tossups count] && [self.tossups objectAtIndex:_currentTossUpIndex]);
}

-(BOOL) hasNextBonus
{
    return (_currentBonusIndex < [self.bonus count] && [self.bonus objectAtIndex:_currentBonusIndex]);
}

-(QBRound*) getNextTossUp
{
    return [self.tossups objectAtIndex:_currentTossUpIndex++];
}

-(QBRound*) getNextBonus
{
    return [self.bonus objectAtIndex:_currentBonusIndex++]; 
}

@end
