//
//  QBGameController.m
//  QuizbowlGame
//
//  Created by jarthurcs on 3/29/14.
//  Copyright (c) 2014 HMC_CS121. All rights reserved.
//

#import "QBGameController.h"
#import "QBRound.h"
#import "CHHTPlayViewController.h"

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
    float _currentTime;
    NSInteger _timeLeftForRound;
    QBQuestion* _currentQuestion;
    QBRound* _currentRound;
    NSTimer* _timer;
    NSInteger _score1;
    NSInteger _score2;
    BOOL _team1answered;
    BOOL _team2answered;
}

// Game control flow

-(void) beginGame
{
    // Start with a tossup
    _state = TossUp;
    _currentRound = [self.level getNextTossUp];
    [self startQuestion];
}

-(void) startQuestion
{
    _currentQuestion = [_currentRound getNextQuestion];
    float displayTime = [_currentQuestion.question length] * timePerChar;
    _currentTime = timeToBuzz + displayTime;
    
    [self restartTimerWithTime:_currentTime];
    
    // Display the question
    [self.questionDisplay showQuestion:_currentQuestion];
    
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
    // No team has attempted an answer at the start of the round
    _team1answered = NO;
    _team2answered = NO;
    
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
        [self.buzzer1 setEnabled:YES];
    }
    
    // Team 2 answered a tossup. Move onto bonus round.
    else if (_state == Team2Answer) {
        _state = Team2Bonus;
        _currentRound = [self.level getNextBonus];
        [self.buzzer2 setEnabled:YES];
    }
    
    // Either no team answered a tossup or a bonus round finished.
    // Move onto the next tossup
    else if(![_currentRound hasNextQuestion])
    {
        // Re-enable both buzzers
        [self.buzzer1 setEnabled:YES];
        [self.buzzer2 setEnabled:YES];

        _state = TossUp;
        _currentRound = [self.level getNextTossUp];
    }
    
    [self startQuestion];
}

-(void)tick:(NSTimer*)timer
{
    // We ran out of time.
    if (_currentTime <= 0) {
        [_timer invalidate];
        // Ran out of time given to answer question. Return to bonus round.
        if (_state == Team1Answer) {
            _state = TossUp;
            if (_team2answered) {
                [self startNextRound];
            } else {
                [self restartTimerWithTime:_timeLeftForRound];
                [self.questionDisplay resumeDisplay];
                [self.buzzer1 setEnabled:NO];
            }
        }
        else if(_state == Team2Answer) {
            _state = TossUp;
            if (_team1answered) {
                [self startNextRound];
            } else {
                [self restartTimerWithTime:_timeLeftForRound];
                [self.questionDisplay resumeDisplay];
                [self.buzzer2 setEnabled:NO];
            }
        }
        else if ([_currentRound hasNextQuestion]) {
            [self startQuestion];
        } else {
            [self startNextRound];
        }
    } else {
        --_currentTime;
        //Fix this
        [self.hud setTimerToTime:_currentTime];
        //self.hud.timer.text = [NSString stringWithFormat:@"%i", _currentTime];
    }
}

-(BOOL) checkAnswerForTeam:(NSInteger)team
{
    NSString* answer = self.answerField.text;
    
    // Reset the entry text field
    self.answerField.text = @"Enter your answer";
    
    // Increment scores if the answer is correct
    if ([_currentQuestion doesMatchAnswer:answer] && team == 1) {
        ++_score1;
        [self.hud updateScore:_score1 forTeam:1];
        return YES;
    }
    else if ([_currentQuestion doesMatchAnswer:answer] && team == 2) {
        ++_score2;
        [self.hud updateScore:_score2 forTeam:2];
        return YES;
    }
    else if (team == 1 && _state == Team1Answer) {
        // Each team only gets one chance to answer the tossup
        [self.buzzer1 setEnabled:NO];
    }
    else if (team == 2 && _state == Team2Answer) {
        [self.buzzer2 setEnabled:NO];
    }
    return NO;
}

- (void)actionBuzzTeam:(NSInteger)teamNumber
{
    // Pause the countdown.
    [_timer invalidate];
        
    switch (_state) {
        case Team1Bonus:
            [self checkAnswerForTeam:1];
            [self.questionDisplay pauseDisplay];
            [self startNextRound];
            break;
        case Team2Bonus:
            [self checkAnswerForTeam:2];
            [self.questionDisplay pauseDisplay];
            [self startNextRound];
            break;
        case Team1Answer:
            if ([self checkAnswerForTeam:1]) {
                [self startNextRound];
            } else {
                _state = TossUp;
                _team1answered = YES;
                self.answerField.hidden = YES;
                if (_team2answered) {
                    [self startNextRound];
                } else {
                    [self restartTimerWithTime:_timeLeftForRound];
                    [self.questionDisplay resumeDisplay];
                }
            }
            break;
        case Team2Answer:
            if ([self checkAnswerForTeam:2]) {
                [self startNextRound];
            } else {
                _state = TossUp;
                _team2answered = YES;
                self.answerField.hidden = YES;
                if (_team1answered) {
                    [self startNextRound];
                } else {
                    [self restartTimerWithTime:_timeLeftForRound];
                    [self.questionDisplay resumeDisplay];
                }
            }
            break;
        case TossUp:
            [self.questionDisplay pauseDisplay];
            if (teamNumber == 1) {
                _state = Team1Answer;
                _timeLeftForRound = _currentTime;
                // Each team gets 10 seconds after buzzing in to answer
                [self restartTimerWithTime:10];
                // Show the answer entry view
                self.answerField.hidden = NO;
            } else {
                _state = Team2Answer;
                _timeLeftForRound = _currentTime;
                _currentTime = 10;
                [self restartTimerWithTime:10];
                // Display the answer entry view
                self.answerField.hidden = NO;
            }
        default:
            break;
    }
}

@end
