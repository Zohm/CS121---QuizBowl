//
//  CHHTHUDView.m
//  Quiz-Bowl
//
//  Created by Zohm on 03/03/14.
//  Copyright (c) 2014 Zohm. All rights reserved.
//

#import "CHHTHUDView.h"
#import "config.h"

@implementation CHHTHUDView


+(instancetype)viewWithRect:(CGRect)r
{
    //create the hud layer
    CHHTHUDView * hud = [[CHHTHUDView alloc] initWithFrame:r];
    hud.userInteractionEnabled = NO;
    
    //the timer
    hud.timer = [[CHHTimerView alloc] initWithFrame: CGRectMake(screenWidth/2-150, 0, 300, 100)];
    hud.timer.seconds = 0;
    [hud addSubview: hud.timer];
    
    //Score Team A
    //"points" label
    UILabel* ptsA = [[UILabel alloc] initWithFrame:CGRectMake(50,30,140,70)];
    ptsA.backgroundColor = [UIColor clearColor];
    ptsA.font = fontHUD;
    ptsA.text = @" Team A :";
    [hud addSubview:ptsA];
    
    //the dynamic points label
    hud.gamePointsTeamA = [CHHTCounterLabelView labelWithFont:fontHUD
                                        frame:CGRectMake(200,30,200,70) andValue:0];
    hud.gamePointsTeamA.textColor = [UIColor colorWithRed:0.38 green:0.098 blue:0.035 alpha:1]; /*#611909*/
    [hud addSubview: hud.gamePointsTeamA];
    
    //Score Team B
    UILabel* ptsB = [[UILabel alloc] initWithFrame:CGRectMake(screenWidth-340,30,140,70)];
    ptsB.backgroundColor = [UIColor clearColor];
    ptsB.font = fontHUD;
    ptsB.text = @" Team B :";
    [hud addSubview:ptsB];
    
    hud.gamePointsTeamB = [CHHTCounterLabelView labelWithFont:fontHUD
                                                        frame:CGRectMake(screenWidth-200,30,200,70) andValue:0];
    hud.gamePointsTeamB.textColor = [UIColor colorWithRed:0.38 green:0.098 blue:0.035 alpha:1]; 
    [hud addSubview: hud.gamePointsTeamB];
    
    
    return hud;
}

-(void) setTimerToTime:(NSInteger)time
{
    [self.timer setSeconds:time];
}

-(void)updateScore:(NSInteger)score forTeam:(NSInteger)team
{
    if (team == 1) {
        [self.gamePointsTeamA countTo:score withDuration:2.0];
    } else {
        [self.gamePointsTeamB countTo:score withDuration:2.0];
    }
}

@end
