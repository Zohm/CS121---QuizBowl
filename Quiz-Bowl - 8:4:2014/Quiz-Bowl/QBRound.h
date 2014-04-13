//
//  QBRound.h
//  QuizbowlGame
//
//  Created by jarthurcs on 3/30/14.
//  Copyright (c) 2014 HMC_CS121. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QBQuestion.h"

@interface QBRound : NSObject

@property NSArray* questions;

@property NSString* intro;

// Used for initializing a tossup round from a question/answer pair
-(instancetype) initWithPair:(NSArray*) pair;

// Used for initializing a bonus round from an array of pairs
-(instancetype) initWithSet: (NSArray*) set;

-(BOOL) hasNextQuestion; 

-(QBQuestion*) getNextQuestion;

-(NSInteger) getTimeForQuestion;


@end
