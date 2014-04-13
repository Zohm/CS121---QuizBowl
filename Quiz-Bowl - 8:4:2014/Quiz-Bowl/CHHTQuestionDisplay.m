//
//  CHHTDisplayQuestionView.m
//  Quiz-Bowl
//
//  Created by jarthurcs on 4/13/14.
//  Copyright (c) 2014 Zohm. All rights reserved.
//

#import "CHHTQuestionDisplay.h"

@implementation CHHTQuestionDisplay


- (instancetype) initWithLabel:(UILabel*) label
{
    self = [super init];
    if (self) {
        self.lblQuestion = label;
    }
    return self;
}

- (void) showQuestion:(QBQuestion*) question
{
    NSString* questionString = question.question;
    nbLetterQ = [questionString length];
    
    [self startTimerWith: questionString];
}

- (void) displayQuestionCharByChar: (NSString *) str andInt: (int) index
{
    self.lblQuestion.text = [NSString stringWithFormat:@"%@%C", self.lblQuestion.text, [str characterAtIndex:index]];
    [NSThread sleepForTimeInterval:0.05f];
}

// Timer functions
- (void) startTimerWith: (NSString *) str
{
    //initialize the timer
    indexLetter = 0;
    
    //activate the timer
    _timer = [NSTimer scheduledTimerWithTimeInterval: 0.01f
                                              target: self
                                            selector: @selector(tick:)
                                            userInfo: str
                                             repeats: YES];
}

- (void) stopTimer
{
    [_timer invalidate];
    _timer = nil;
}

//timer tick function: at each tick, display a new letter.
- (void) tick:(NSTimer *)timer
{
    [self displayQuestionCharByChar:[timer userInfo] andInt:indexLetter];
    indexLetter++;
    
    if(indexLetter == nbLetterQ)
        [self stopTimer];
}

@end
