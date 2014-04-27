//
//  CHHTDisplayQuestionView.m
//  Quiz-Bowl
//
//  Created by jarthurcs on 4/13/14.
//  Copyright (c) 2014 Zohm. All rights reserved.
//

#import "CHHTQuestionDisplay.h"
#import "config.h"

@implementation CHHTQuestionDisplay
{
    int indexLetter;
    NSTimer *_timer;
    int nbLetterQ;
    NSString* _str;
}

- (instancetype) initWithLabel:(UILabel*) label
{
    self = [super init];
    if (self) {
        self.lblQuestion = label;
    }
    return self;
}

- (void)showQuestion:(QBQuestion*) question
{
    // Reset the label
    self.lblQuestion.text = @"";
    
    NSString* questionString = question.question;
    nbLetterQ = [questionString length];
    
    [self startTimerWith: questionString];
}

-(void)showText:(NSString *)text
{
    nbLetterQ = [text length];
    [self startTimerWith:text];
}

-(void)resetDisplay
{
    self.lblQuestion.text = @""; 
}

-(void) pauseDisplay
{
    [_timer invalidate];
}

-(void) resumeDisplay
{
    _timer = [NSTimer scheduledTimerWithTimeInterval: timePerChar
                                              target: self
                                            selector: @selector(tick:)
                                            userInfo: nil
                                             repeats: YES];
}

- (void) displayQuestionCharByChar: (NSString *) str andInt: (int) index
{
    self.lblQuestion.text = [NSString stringWithFormat:@"%@%C", self.lblQuestion.text, [str characterAtIndex:index]];
}

// Timer functions
- (void) startTimerWith: (NSString *) str
{
    // Initialize the timer
    indexLetter = 0;
    
    // Store the string to display
    _str = str;
    
    [self resumeDisplay];
}

- (void) stopTimer
{
    [_timer invalidate];
    _timer = nil;
}

//timer tick function: at each tick, display a new letter.
- (void) tick:(NSTimer *)timer
{
    [self displayQuestionCharByChar:_str andInt:indexLetter];
    indexLetter++;
    
    if(indexLetter == nbLetterQ)
        [self stopTimer];
}

@end
