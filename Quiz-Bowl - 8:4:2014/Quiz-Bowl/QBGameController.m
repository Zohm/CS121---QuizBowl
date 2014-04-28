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
#import "QBMainModeEndScreen.h"

// Defines the possible states the game can be in.
typedef enum {
    TossUp = 0,
    Team1BonusIntro,
    Team2BonusIntro,
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

-(instancetype)init{
    self = [super init];
    if (self) {
        self.audioController = [[QBAudioController alloc] init];
        [self.audioController preloadAudioEffects: kAudioEffectFiles];
    }
    return self;
}

// Public getters
-(NSInteger) getScoreForTeam:(NSInteger)team
{
    if (team == 1) {
        return _score1;
    } else {
        return _score2;
    }
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

-(void) returnToTossUp
{
    _state = TossUp;
    
    // Hide the answer field
    self.answerField.hidden = YES;
    
    // Resume the timer and question display
    [self restartTimerWithTime:_timeLeftForRound];
    [self.questionDisplay resumeDisplay];
    
    // Enable/disable buzzers appropriately
    if (_team1answered) {
        [self.buzzer1 setEnabled: NO];
        [self.buzzer2 setEnabled: YES];
    } else {
        [self.buzzer2 setEnabled: NO];
        [self.buzzer1 setEnabled: YES];
    }
}

-(void) startBonusRoundForTeam:(NSInteger)team
{
    _currentRound = [self.level getNextBonus];

    [self.buzzer1 setEnabled: NO]; // Buzzing in is not allowed during the intro
    [self.buzzer2 setEnabled: NO];
    
    // Display the intro text
    float timeToDisplay = [_currentRound.intro length] * timePerChar;
    [self.questionDisplay resetDisplay];
    [self restartTimerWithTime:timeToDisplay + introPauseTime];
    [self.questionDisplay showText:_currentRound.intro];
    
    if (team == 1) {
        _state = Team1BonusIntro;
    }
    
    if (team == 2) {
        _state = Team2BonusIntro;
    }
}

-(void) startNextBonusQuestion
{
    self.answerField.hidden = NO;
    
    if (_state == Team1BonusIntro) {
        _state = Team1Bonus;
        [self.buzzer1 setEnabled: YES];
        [self.buzzer2 setEnabled: NO];
    }
    
    if (_state == Team2BonusIntro) {
        _state = Team2Bonus;
        [self.buzzer1 setEnabled: NO];
        [self.buzzer2 setEnabled: YES];
    }
    
    [self startQuestion];
}

-(void) startNextTossUp
{
    _state = TossUp;
    
    // Hide the answer field
    self.answerField.hidden = YES;
    
    // No team has attempted an answer at the start of the round
    _team1answered = NO;
    _team2answered = NO;
    
    // Re-enable both buzzers
    [self.buzzer1 setEnabled: YES];
    [self.buzzer2 setEnabled: YES];
    
    // Load the tossup round
    _currentRound = [self.level getNextTossUp];
    
    [self startQuestion];
}

-(void) startAnswerModeForTeam:(NSInteger)team
{
    _timeLeftForRound = _currentTime;
    
    // Play buzzer sound
    [self.audioController playEffect:BuzzerSound];
    
    // Each team gets some time after buzzing in to answer
    [self restartTimerWithTime: timeToAnswer];
    
    // Show the answer entry view
    self.answerField.hidden = NO;
    
    if (team == 1) {
        _state = Team1Answer;
        // Only allow team 1 to buzz in during their chance to answer.
        [self.buzzer1 setEnabled: YES];
        [self.buzzer2 setEnabled: NO];
    }
    
    else {
        _state = Team2Answer;
        [self.buzzer1 setEnabled: NO];
        [self.buzzer2 setEnabled: YES];
    }
}

-(void)tick:(NSTimer*)timer
{
    if (_currentTime <= 0) { // The timer ran out
        [_timer invalidate];
        if (_state == Team1Answer) { // Team 1 ran out of time while answering a question.
            
            if (_team2answered) { // If both teams have attempted an answer, move on to next tossup.
                [self startNextTossUp];
            }
            else { // Otherwise, return to the tossup round
                _team1answered = YES;
                [self returnToTossUp];
            }
        }
        else if(_state == Team2Answer) { // Team 2 ran out of time to answer a question.
            
            if (_team1answered) {
                [self startNextTossUp];
            }
            else {
                _team2answered = YES;
                [self returnToTossUp];
            }
        }
        else if (_state == Team1BonusIntro || _state == Team2BonusIntro) { // Finished bonus intro.
            [self startNextBonusQuestion];
        }
        else if ([_currentRound hasNextQuestion]) { // Still in bonus round.
            [self startNextBonusQuestion];
        }
        else if ([self.level hasNextTossUp]){ // Move on to next toss up.
            [self startNextTossUp];
        }
        else {
            // End the game, move on to end game screen.
            [self.viewController gameIsFinished];
        }
    } else {
        --_currentTime;
        [self.hud setTimerToTime:_currentTime];
    }
}

-(BOOL) checkAnswerForTeam:(NSInteger)team
{
    NSString* answer = self.answerField.text;
    
    // Reset the entry text field
    self.answerField.text = @"";
    
    // Increment scores if the answer is correct
    if ([_currentQuestion doesMatchAnswer:answer] && team == 1) {
        [self.audioController playEffect: RightAnswerSound];
        _score1 += pointsPerQuestion;
        [self.hud updateScore:_score1 forTeam:1];
        return YES;
    }
    
    else if ([_currentQuestion doesMatchAnswer:answer] && team == 2) {
        [self.audioController playEffect: RightAnswerSound];
        _score2 += pointsPerQuestion;
        [self.hud updateScore:_score2 forTeam:2];
        return YES;
    }
    [self.audioController playEffect:WrongAnswerSound];
    return NO;
}

- (void)actionBuzzTeam:(NSInteger)teamNumber
{
    // Pause the countdown.
    [_timer invalidate];
    
    // Pause the text display
    [self.questionDisplay pauseDisplay];
    
    if (_state == Team1Bonus || _state == Team2Bonus) {
        
        if (_state == Team1Bonus) {
            [self checkAnswerForTeam:1];
        }
        else {
            [self checkAnswerForTeam:2];
        }
        
        if ([_currentRound hasNextQuestion]) {
            [self startNextBonusQuestion];
        }
        else if ([self.level hasNextTossUp]){
            [self startNextTossUp];
        }
        else {
            [self.viewController gameIsFinished];
        }
    }
    
    else if (_state == Team1Answer) {
        
        if ([self checkAnswerForTeam:1]) { // Correct answer! Move onto bonus round.
            [self startBonusRoundForTeam:1];
        }
        else if (_team2answered) { // Both teams got it wrong. Move onto next tossup.
            if ([self.level hasNextTossUp]) {
                [self startNextTossUp];
            } else {
                [self.viewController gameIsFinished];
            }
        }
        else { // The other team still has a chance. Return to tossup.
            _team1answered = YES;
            [self returnToTossUp];
        }
    }
    
    else if (_state == Team2Answer) {
        
        if ([self checkAnswerForTeam:2]) { // Correct answer! Move onto bonus round.
            [self startBonusRoundForTeam:2];
        }
        else if (_team1answered) { // Both teams got it wrong. Move onto next tossup.
            if ([self.level hasNextTossUp]) {
                [self startNextTossUp];
            } else {
                [self.viewController gameIsFinished];
            }
        }
        else { // The other team still has a chance. Return to tossup.
            _team2answered = YES;
            [self returnToTossUp];
        }
    }
    
    else if (_state == TossUp) {
        [self startAnswerModeForTeam:teamNumber];
    }
    
}

@end
