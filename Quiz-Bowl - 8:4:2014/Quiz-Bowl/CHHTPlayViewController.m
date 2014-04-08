//
//  CHHTPlayViewController.m
//  Quiz-Bowl
//
//  Created by Zohm on 25/02/14.
//  Copyright (c) 2014 Zohm. All rights reserved.
//

#import "CHHTPlayViewController.h"
#import "config.h"
#import "CHHTimerView.h"
#include "math.h"

@interface CHHTPlayViewController ()

@end

@implementation CHHTPlayViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.scoreTeamA = 0;
        self.scoreTeamB = 0;
    }
    return self;
}

- (void) receiveNotification: (NSNotification *) notification
{
    //If a notifcation is received saying that the timer is over, then pass to the next question
    if ([[notification name] isEqualToString:@"TimerUp"])
    {
        //Put a delay of 0.5 seconds between each question
        [NSThread sleepForTimeInterval:delayQ];
        
        //Show next question
        //[self showQuestion];
        // ADD FUNCTION TO ANSWER AND GO TO THE NEXT QUESTION FIRST!!!! For now just stay on the screen doing nothing.
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //add a notificator to self: will check if the timer is stopped (due to a question answered or if the time is over)
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveNotification:) name:@"TimerUp" object:nil];
    
    //create the path to get the plist used for the practice mode
    NSString *fileName = @"Question.plist";
    NSString *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:fileName];
    //get the data in the plist file
    NSDictionary *tempDict = [NSDictionary dictionaryWithContentsOfFile: path];
    NSAssert(tempDict, @"set of questions not found");
    self.questions = [[NSMutableArray alloc] initWithArray:[tempDict objectForKey:@"questions"]];
    self.timeToSolve = [tempDict[@"timeToSolve"] intValue];
    self.pointPerQuestion = [tempDict[@"pointPerQuestion"] intValue];
    
    /* TEST PURPOSE => TO BE FIXED
    NSLog(@"%d", [self pointScoredWithXSecondsLeft:40]);
    NSLog(@"%d", [self pointScoredWithXSecondsLeft:30]);
    NSLog(@"%d", [self pointScoredWithXSecondsLeft:20]);
    NSLog(@"%d", [self pointScoredWithXSecondsLeft:10]);
     */
    
    //init the HUD
    CHHTHUDView * hudView = [CHHTHUDView viewWithRect:CGRectMake(0, 0, screenWidth, screenHeight)];
    [self.view addSubview:hudView];
    self.hud = hudView;
    self.lblQuestion.text = @"";
    //init the game data: score team A and B
    CHHTGameData * gd = [[CHHTGameData alloc] init];
    [gd setScoresWithPointsTeamA:0 andPointsTeamB:0];
    self.gameData = gd;
    
    // autre init à faire
    
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    //start timer
    CHHTGameController *gc = [[CHHTGameController alloc] init];
    self.gameC = gc;
    [self.gameC startTimerWith:self.timeToSolve andTimer:self.hud.timer];
    
    //FOR TEST PURPOSE => this will be moved to where the player is scoreing point + score should be set by the function created to this purpose.
    
    self.gameData.scoreTeamA += 100;
    [self.hud.gamePointsTeamA countTo:self.gameData.scoreTeamA withDuration:1.5];
    self.gameData.scoreTeamB += 80;
    [self.hud.gamePointsTeamB countTo:self.gameData.scoreTeamB withDuration:1];
     
    
    [self showQuestion];
}

- (void) showQuestion
{
    NSArray *selectedQuestion = self.questions[0];
    NSString *questionString = selectedQuestion[0];
    self.answer = selectedQuestion[1];
    nbLetterQ = [questionString length];
    
    [self startTimerWith:questionString];
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

- (int) pointScoredWithXSecondsLeft: (int) secondsLeft
{
    int resultScore = 0;
    
    resultScore = (secondsLeft / self.timeToSolve) * 100;
    
    return resultScore;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
