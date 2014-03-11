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
    
    return hud;
}

@end
