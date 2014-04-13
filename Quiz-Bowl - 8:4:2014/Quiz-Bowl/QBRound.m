//
//  QBRound.m
//  QuizbowlGame
//
//  Created by jarthurcs on 3/30/14.
//  Copyright (c) 2014 HMC_CS121. All rights reserved.
//

#import "QBRound.h"

@implementation QBRound
{
    NSInteger currentIndex;
}

-(instancetype) initWithPair:(NSArray *)pair
{
    self = [super init];
    if (self) {
        self.questions = [NSArray arrayWithObject:[[QBQuestion alloc] initWithPair:pair]];
    }
    return self;
}

-(instancetype) initWithSet:(NSArray *)set
{
    self = [super init];
    if (self) {
        NSMutableArray* questions = [NSMutableArray array];
        for (int i = 0; i < [set count]; ++i) {
            if ([[set objectAtIndex:i] isKindOfClass:[NSString class]]) {
                self.intro = [set objectAtIndex:i];
            } else {
                NSArray* pair = [set objectAtIndex:i];
                [questions addObject:[[QBQuestion alloc] initWithPair:pair]];
            }
        }
        self.questions = [NSArray arrayWithArray:questions];
    }
    return self;
}

-(BOOL) hasNextQuestion
{
    return currentIndex < [self.questions count] && [self.questions objectAtIndex:currentIndex];
}

-(QBQuestion*) getNextQuestion
{
    // Return NULL if there are no questions left
    if (![self hasNextQuestion]) {
        return NULL;
    }
    return [self.questions objectAtIndex:currentIndex++];
}

-(NSInteger) getTimeForQuestion
{
    // For now, we'll give 10 seconds for every answer
    return 10;
}

@end
