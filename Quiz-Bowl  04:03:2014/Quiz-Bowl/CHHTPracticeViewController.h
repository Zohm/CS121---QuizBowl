//
//  CHHTPracticeViewController.h
//  Quiz-Bowl
//
//  Created by Zohm on 25/02/14.
//  Copyright (c) 2014 Zohm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CHHTHUDView.h"
#import "CHHTGameController.h"

@interface CHHTPracticeViewController : UIViewController
{
    int numCorrect;
    int nbQuestion;
}

// Labels (question + answers)
@property (weak, nonatomic) IBOutlet UILabel *lblQuestion;
@property (weak, nonatomic) IBOutlet UILabel *lblAnswerA;
@property (weak, nonatomic) IBOutlet UILabel *lblAnswerB;
@property (weak, nonatomic) IBOutlet UILabel *lblAnswerC;
@property (weak, nonatomic) IBOutlet UILabel *lblAnswerD;

// Buttons
@property (weak, nonatomic) IBOutlet UIButton *btnBack;
@property (weak, nonatomic) IBOutlet UIButton *btnA;
@property (weak, nonatomic) IBOutlet UIButton *btnB;
@property (weak, nonatomic) IBOutlet UIButton *btnC;
@property (weak, nonatomic) IBOutlet UIButton *btnD;

// Useful properties to execute a game
@property (strong, nonatomic) NSMutableArray *questions;
@property (weak,nonatomic) NSString *answer;
@property (assign, nonatomic) int timeToSolve;

// HUD
@property (weak, nonatomic) CHHTHUDView *hud;
@property (weak, nonatomic) CHHTGameController * gameC;

// Button functions
- (IBAction)btnPressedA:(id)sender;
- (IBAction)btnPressedB:(id)sender;
- (IBAction)btnPressedC:(id)sender;
- (IBAction)btnPressedD:(id)sender;

// Main function: init the set of question and launch the game
- (void) showNextQuestion;


@end
