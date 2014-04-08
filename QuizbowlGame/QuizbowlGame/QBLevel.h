//
//  QBLevel.h
//  QuizbowlGame
//
//  Created by jarthurcs on 3/7/14.
//  Copyright (c) 2014 HMC_CS121. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QBRound.h"

@interface QBLevel : NSObject

// An array of toss up questions
@property (strong, nonatomic) NSArray* tossups;

// An array of bonus questions
@property (strong, nonatomic) NSArray* bonus;

// Factory method to load a level from a file
+(instancetype) levelWithName:(NSString* )name;

-(BOOL) hasNextTossUp;

-(BOOL) hasNextBonus;

-(QBRound*) getNextTossUp;

-(QBRound*) getNextBonus;

@end
