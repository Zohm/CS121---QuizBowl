//
//  CHHTGameData.m
//  Quiz-Bowl
//
//  Created by Zohm on 06/04/14.
//  Copyright (c) 2014 Zohm. All rights reserved.
//

#import "CHHTGameData.h"

@implementation CHHTGameData

//custom setter - keep the score positive + allow to start with a score > 0.
-(void)setScoresWithPointsTeamA:(int)pointsTeamA andPointsTeamB: (int) pointsTeamB
{
    _scoreTeamA = pointsTeamA;
    _scoreTeamB = pointsTeamB;
    
    if (_scoreTeamA < 0)
        _scoreTeamA = 0;
    if (_scoreTeamB < 0)
        _scoreTeamB = 0;
}

@end
