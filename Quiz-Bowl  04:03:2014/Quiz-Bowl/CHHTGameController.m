//
//  CHHTGameController.m
//  Quiz-Bowl
//
//  Created by Zohm on 04/03/14.
//  Copyright (c) 2014 Zohm. All rights reserved.
//

#import "CHHTGameController.h"
#import "CHHTPracticeViewController.h"

@implementation CHHTGameController

- (void) startTimerWith: (int) timeTosolve andTimer: (CHHTimerView *) hudTimer
{
    //initialize the timer
    _secondLeft = timeTosolve;
    [hudTimer setSeconds:_secondLeft];
    
    //activate the timer
    _timer = [NSTimer scheduledTimerWithTimeInterval: 1.0
                      target: self
                      selector: @selector(tick:) 
                      userInfo: hudTimer
                      repeats: YES];
}

- (void) stopTimer
{
    [_timer invalidate];
    _timer = nil;
}

- (void) tick:(NSTimer *)timer
{
    _secondLeft--;
    [[timer userInfo] setSeconds:_secondLeft];
    
    if(_secondLeft == 0)
        [self stopTimer];
}

@end
