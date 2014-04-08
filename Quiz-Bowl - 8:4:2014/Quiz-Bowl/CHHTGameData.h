//
//  CHHTGameData.h
//  Quiz-Bowl
//
//  Created by Zohm on 06/04/14.
//  Copyright (c) 2014 Zohm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CHHTGameData : NSObject

@property (assign, nonatomic) int scoreTeamA;
@property (assign, nonatomic) int scoreTeamB;

// Set-er function to make sure the score is not negative.
-(void)setScoresWithPointsTeamA:(int)pointsTeamA andPointsTeamB: (int) pointsTeamB;

@end
