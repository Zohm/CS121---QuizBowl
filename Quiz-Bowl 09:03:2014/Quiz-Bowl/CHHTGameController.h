//
//  CHHTGameController.h
//  Quiz-Bowl
//
//  Created by Zohm on 04/03/14.
//  Copyright (c) 2014 Zohm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CHHTimerView.h"

@interface CHHTGameController : NSObject
{
    int _secondLeft;
    NSTimer *_timer;
}

// Timer's functions
- (void) startTimerWith: (int) timeTosolve andTimer: (CHHTimerView *) hudTimer;
- (void) stopTimer;
- (void) tick: (NSTimer *) timer;

@end
