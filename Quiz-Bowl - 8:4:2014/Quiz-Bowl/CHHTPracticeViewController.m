//
//  CHHTPracticeViewController.m
//  Quiz-Bowl
//
//  Created by Zohm on 25/02/14.
//  Copyright (c) 2014 Zohm. All rights reserved.
//

#import "CHHTPracticeViewController.h"
#import "CHHTHUDView.h"
#import "config.h"
#import "CHHTPracticeEndScreenViewController.h"

@interface CHHTPracticeViewController ()

@end

@implementation CHHTPracticeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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
        [self showNextQuestion];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    //add a notificator to self: will check if the timer is stopped (due to a question answered or if the time is over)
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveNotification:) name:@"TimerUp" object:nil];
    
    //create the path to get the plist used for the practice mode
    NSString *fileName = @"PracticeQuestions.plist";
    NSString *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:fileName];
    //get the data in the plist file
    NSDictionary *tempDict = [NSDictionary dictionaryWithContentsOfFile: path];
    NSAssert(tempDict, @"set of practice questions not found");
    
    self.questions = [[NSMutableArray alloc] initWithArray:[tempDict objectForKey:@"Questions"]];
    numCorrect = 0;
    if([self.questions count] < 20)
        nbQuestion = [self.questions count];
    else
        nbQuestion = 20;
    nbQtmp = nbQuestion;
    
    self.timeToSolve = [tempDict[@"TimePerQuestion"] intValue];
    CHHTHUDView * hudView = [CHHTHUDView viewWithRect:CGRectMake(0, 0, screenWidth, screenHeight)];
    [self.view addSubview:hudView];
    self.hud = hudView;

    
    //initialization of the font for the labels
    self.lblQuestion.font = fontHUD;
    self.lblAnswerA.font = fontHUD;
    self.lblAnswerB.font = fontHUD;
    self.lblAnswerC.font = fontHUD;
    self.lblAnswerD.font = fontHUD;
    
    
    [self showNextQuestion];
}


- (void) showNextQuestion
{
    if(nbQuestion > 0)
    {        
        //choose a random question
        int randomIndex = arc4random()%nbQuestion;
        NSArray *selectedQuestion = self.questions[randomIndex];
        
        //display the question and the 4 answers
        self.lblQuestion.text = selectedQuestion[0];
        self.lblAnswerA.text = selectedQuestion[1];
        self.lblAnswerB.text = selectedQuestion[2];
        self.lblAnswerC.text = selectedQuestion[3];
        self.lblAnswerD.text = selectedQuestion[4];
        self.answer = selectedQuestion[5];
        
        //update the number of questions left + delete the question of the array that has been selected (avoid to have the same question asked 2 times).
        nbQuestion--;
        [self.questions removeObjectAtIndex:randomIndex];
        
        //start timer
        CHHTGameController *gc = [[CHHTGameController alloc] init];
        self.gameC = gc;
        [self.gameC startTimerWith:self.timeToSolve andTimer:self.hud.timer];

    }
    else //Game finished
    {
        // Remove the observer
        [[NSNotificationCenter defaultCenter] removeObserver:self];
        
        // Display end game screen
        CHHTPracticeEndScreenViewController *endView =
                [self.storyboard instantiateViewControllerWithIdentifier:@"PracticeEndScreen"];
        endView.score = numCorrect;
        endView.nbQuestion = nbQtmp;
        endView.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        [self presentViewController:endView animated:YES completion:NULL];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnPressedA:(id)sender
{
    //check if the answer is correct
    if([self.answer isEqualToString:self.lblAnswerA.text])
        numCorrect++; 
    
    //stop the timer
    [self.gameC stopTimer];
}

- (IBAction)btnPressedB:(id)sender
{
    
    if([self.answer isEqualToString:self.lblAnswerB.text])
        numCorrect++;
    
    [self.gameC stopTimer];
}

- (IBAction)btnPressedC:(id)sender
{    
    if([self.answer isEqualToString:self.lblAnswerC.text])
        numCorrect++; 

    [self.gameC stopTimer];
}

- (IBAction)btnPressedD:(id)sender
{ 
    if([self.answer isEqualToString:self.lblAnswerD.text])
        numCorrect++;
    
    [self.gameC stopTimer];
}

- (IBAction)btnPressedBack:(id)sender
{
    [self.gameC stopTimer];
}





@end
