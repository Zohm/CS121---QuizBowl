//
//  QBRound.h
//  QuizbowlGame
//
//  Created by jarthurcs on 3/7/14.
//  Copyright (c) 2014 HMC_CS121. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QBRound : NSObject

// An array of toss up questions
@property (assign, nonatomic) NSArray* tossups;

// An array of bonus questions
@property (assign, nonatomic) NSArray* bonus;

// Factory method to load a round from a file
+(instancetype) roundWithName:(NSString* )name;

@end
