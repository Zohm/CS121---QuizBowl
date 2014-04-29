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
#import "QBMainModeEndScreen.h"
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

- (IBAction) returnToMenu:(id)sender
{
    [self.controller stopGame];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //add a notificator to self: will check if the timer is stopped (due to a question answered or if the time is over)
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveNotification:) name:@"TimerUp" object:nil];
    
    //Initialize the game controller
    self.controller = [[QBGameController alloc] init];
    self.controller.buzzer1 = self.btnBuzzerA;
    [self.controller.buzzer1 setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    self.controller.buzzer2 = self.btnBuzzerB;
    [self.controller.buzzer2 setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    self.controller.answerField = self.answerField;
    self.controller.answerField.hidden = YES;
    self.controller.questionDisplay = [[CHHTQuestionDisplay alloc]initWithLabel:self.lblQuestion];
    
    //create the path to get the plist used for the practice mode
    NSString *fileName = @"Question.plist";
    NSString *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:fileName];
    //get the data in the plist file
    NSDictionary *tempDict = [NSDictionary dictionaryWithContentsOfFile: path];
    NSAssert(tempDict, @"set of questions not found");
    self.questions = [[NSMutableArray alloc] initWithArray:[tempDict objectForKey:@"questions"]];
    self.timeToSolve = [tempDict[@"timeToSolve"] intValue];
    self.pointPerQuestion = [tempDict[@"pointPerQuestion"] intValue];
    
    //Init the HUD
    CHHTHUDView * hudView = [CHHTHUDView viewWithRect:CGRectMake(0, 0, screenWidth, screenHeight)];
    [self.view addSubview:hudView];
    self.hud = hudView;
    self.lblQuestion.text = @"";
    self.controller.hud = hudView;
    
    //Init the game data: score team A and B
    CHHTGameData * gd = [[CHHTGameData alloc] init];
    [gd setScoresWithPointsTeamA:0 andPointsTeamB:0];
    self.gameData = gd;
    
    // Set up the level
    self.controller.level = [QBLevel levelWithName:@"testquestions"];
    
    // Create delegation relationship between game and view controllers
    self.controller.viewController = self;
    
    // Start the game
    [self.controller beginGame];
}

-(void) gameIsFinished
{
    // Display the end game screen
    QBMainModeEndScreenViewController *endView = [self.storyboard instantiateViewControllerWithIdentifier:@"MainModeEndScreen"];
    endView.scoreTeamA = [self.controller getScoreForTeam:1];
    endView.scoreTeamB = [self.controller getScoreForTeam:2];
    endView.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentViewController:endView animated:YES completion:NULL];
}

-(IBAction)buzzTeam1:(id)sender
{
    [self.controller actionBuzzTeam:1];
}

-(IBAction)buzzTeam2:(id)sender
{
    [self.controller actionBuzzTeam:2];
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
