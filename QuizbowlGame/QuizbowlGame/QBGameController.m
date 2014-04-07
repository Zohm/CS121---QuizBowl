//
//  QBGameController.m
//  QuizbowlGame
//
//  Created by jarthurcs on 3/29/14.
//  Copyright (c) 2014 HMC_CS121. All rights reserved.
//

#import "QBGameController.h"
#import "QBRound.h"

// Defines the possible states the game can be in.
typedef enum {
    TossUp = 0,
    Team1Bonus,
    Team2Bonus,
    Team1Answer,
    Team2Answer,
    EndGame
} gameState;

@implementation QBGameController
{
    gameState _state;
    NSInteger _currentTime;
    QBQuestion* _currentQuestion;
    QBRound* _currentRound;
    NSTimer* _timer;
}

-(void) beginGame
{
    // Start with a tossup
    _state = TossUp;
    _currentRound = [self.level getNextTossUp];
    [self startQuestion];
}

- (void) setHud:(QBHudView*) hud
{
    _hud = hud;
    // Have the buzzers in the hud select their respective actions
    [hud.buzzer1 addTarget:self action:@selector(actionBuzzTeam:)
          forControlEvents:UIControlEventTouchUpInside];
    [hud.buzzer2 addTarget:self action:@selector(actionBuzzTeam:)
          forControlEvents:UIControlEventTouchUpInside];
}

-(void) startQuestion
{
    _currentQuestion = [_currentRound getNextQuestion];
    //_currentTime = [_currentRound getTimeForQuestion];
    _currentTime = 10;
    [self resume];
    
    // Display the question
    self.hud.question.text = [NSString stringWithFormat:@"%i",_state];
    
}

-(void)resume
{
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                              target:self
                                            selector:@selector(tick:)
                                            userInfo:Nil repeats:YES];
}

-(void) startNextRound
{
    // The game ends when we run out of tossup or bonus questions.
    if (!([self.level hasNextTossUp] && [self.level hasNextBonus])) {
        _state = EndGame;
        // Display the end game screen
        return;
    }
    
    // Team 1 answered a tossup. Move onto bonus round.
    if (_state == Team1Answer) {
        _state = Team1Bonus;
        _currentRound = [self.level getNextBonus];
    }
    
    // Team 2 answered a tossup. Move onto bonus round.
    else if (_state == Team2Answer) {
        _state = Team2Bonus;
        _currentRound = [self.level getNextBonus];
    }
    
    // Either no team answered a tossup or a bonus round finished.
    // Move onto the next tossup
    else
    {
        _state = TossUp;
        _currentRound = [self.level getNextTossUp];
    }
    [self startQuestion];
}

-(void)tick:(NSTimer*)timer
{
    // We ran out of time. Move on to the next question.
    if (_currentTime <= 0) {
        [_timer invalidate];
        if ([_currentRound hasNextQuestion]) {
            [self startQuestion];
        } else {
            [self startNextRound];
        }
    } else {
        --_currentTime;
        self.hud.timer.text = [NSString stringWithFormat:@"%i", _currentTime];
    }
}

- (void)actionBuzzTeam:(UIButton*) buzzer
{
    // Pause the countdown.
    [_timer invalidate];
    
    switch (_state) {
        case Team1Bonus:
            // Check the given answer
            NSLog(@"Checking answer");
            [self startNextRound];
            break;
        case Team2Bonus:
            // Check the given answer
            NSLog(@"Checking answer");
            [self startNextRound];
            break;
        case Team1Answer:
            // Check the given answer
            NSLog(@"Checking answer");
            [self startNextRound];
            break;
        case Team2Answer:
            // Check the given answer
            NSLog(@"Checking answer");
            [self startNextRound];
            _currentTime = 10;
            break;
        case TossUp:
            if ([buzzer isEqual:self.hud.buzzer1]) {
                _state = Team1Answer;
                self.hud.question.text = [NSString stringWithFormat:@"%i",_state];
                // Give 10 seconds to answer the question
                _currentTime = 10;
                // Show the answer entry view
                self.answerView.hidden = NO;
            } else {
                _state = Team2Answer;
                self.hud.question.text = [NSString stringWithFormat:@"%i",_state];
                _currentTime = 10;
                // Display the answer entry view
                self.answerView.hidden = NO;
            }
        default:
            break;
    }
    
    self.hud.question.text = [NSString stringWithFormat:@"%i",_state];
    // Resume the countdown
    [self resume];
}

@end
