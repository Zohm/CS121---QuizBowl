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
    NSInteger _timeLeftForRound;
    QBQuestion* _currentQuestion;
    QBRound* _currentRound;
    NSTimer* _timer;
    NSInteger _score1;
    NSInteger _score2;
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
    [self restartTimerWithTime:10];
    
    // Display the question
    self.hud.question.text = [NSString stringWithFormat:@"%@",_currentQuestion.question];
    
}

-(void)restartTimerWithTime:(NSInteger)time
{
    [_timer invalidate];
    _currentTime = time;
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
        [self.hud.buzzer1 setEnabled:YES];
    }
    
    // Team 2 answered a tossup. Move onto bonus round.
    else if (_state == Team2Answer) {
        _state = Team2Bonus;
        _currentRound = [self.level getNextBonus];
        [self.hud.buzzer2 setEnabled:YES];
    }
    
    // Either no team answered a tossup or a bonus round finished.
    // Move onto the next tossup
    else if(![_currentRound hasNextQuestion])
    {
        // Re-enable both buzzers
        [self.hud.buzzer1 setEnabled:YES];
        [self.hud.buzzer2 setEnabled:YES];

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

-(BOOL) checkAnswerForTeam:(NSInteger)team
{
    NSString* answer = self.answerView.answerField.text;
    
    // Reset the entry text field
    self.answerView.answerField.text = @"Enter your answer";
    
    // Increment scores if the answer is correct
    if ([_currentQuestion doesMatchAnswer:answer] && team == 1) {
        ++_score1;
        self.hud.score1.text = [NSString stringWithFormat:@"score: %i", _score1];
        return YES;
    }
    else if ([_currentQuestion doesMatchAnswer:answer] && team == 2) {
        ++_score2;
        self.hud.score2.text = [NSString stringWithFormat:@"score: %i", _score2];
        return YES;
    }
    else if (team == 1 && _state == Team1Answer) {
        // Each team only gets one chance to answer the tossup
        [self.hud.buzzer1 setEnabled:NO];
    }
    else if (team == 2 && _state == Team2Answer) {
        [self.hud.buzzer2 setEnabled:NO];
    }
    return NO;
}

- (void)actionBuzzTeam:(UIButton*) buzzer
{
    // Pause the countdown.
    [_timer invalidate];
    
    switch (_state) {
        case Team1Bonus:
            [self checkAnswerForTeam:1];
            [self startNextRound];
            break;
        case Team2Bonus:
            [self checkAnswerForTeam:2];
            [self startNextRound];
            break;
        case Team1Answer:
            if ([self checkAnswerForTeam:1]) {
                [self startNextRound];
            } else {
                _state = TossUp;
                self.answerView.hidden = YES;
                [self restartTimerWithTime:_timeLeftForRound];
            }
            break;
        case Team2Answer:
            if ([self checkAnswerForTeam:2]) {
                [self startNextRound];
            } else {
                _state = TossUp;
                self.answerView.hidden = YES;
                [self restartTimerWithTime:_timeLeftForRound];
            }
            break;
        case TossUp:
            if ([buzzer isEqual:self.hud.buzzer1]) {
                _state = Team1Answer;
                _timeLeftForRound = _currentTime;
                // Each team gets 10 seconds after buzzing in to answer
                [self restartTimerWithTime:10];
                // Show the answer entry view
                self.answerView.hidden = NO;
            } else {
                _state = Team2Answer;
                _timeLeftForRound = _currentTime;
                _currentTime = 10;
                [self restartTimerWithTime:10];
                // Display the answer entry view
                self.answerView.hidden = NO;
            }
        default:
            break;
    }
}

@end
