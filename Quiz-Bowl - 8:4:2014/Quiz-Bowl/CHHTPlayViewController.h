//
//  CHHTPlayViewController.h
//  Quiz-Bowl
//
//  Created by Zohm on 25/02/14.
//  Copyright (c) 2014 Zohm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CHHTHUDView.h"
#import "CHHTGameController.h"
#import "CHHTGameData.h"
#import "QBGameController.h"
#import "QBGameControllerDelegate.h"

@interface CHHTPlayViewController : UIViewController<QBGameControllerDelegate>
{
    int indexLetter;
    NSTimer *_timer;
    int nbLetterQ;
}

// Game controller
@property (strong, nonatomic) QBGameController* controller;

//button back -> go back to the menu view
@property (weak, nonatomic) IBOutlet UIButton *btnBack;
@property (weak, nonatomic) IBOutlet UIButton *btnBuzzerA;
@property (weak, nonatomic) IBOutlet UIButton *btnBuzzerB;

// Answer field
@property (weak, nonatomic) IBOutlet UITextField *answerField;

//Label
@property (weak, nonatomic) IBOutlet UILabel *lblQuestion;

// Useful properties to execute a game
@property (strong, nonatomic) NSMutableArray *questions;
@property (strong,nonatomic) NSString *answer;
@property (assign, nonatomic) int timeToSolve;
@property (nonatomic) int pointPerQuestion;
@property (nonatomic) int scoreTeamA;
@property (nonatomic) int scoreTeamB;

// HUD
@property (weak, nonatomic) CHHTHUDView *hud;
@property (weak, nonatomic) CHHTGameController * gameC;
@property (strong, nonatomic) CHHTGameData * gameData;

// Buzzer selectors
-(IBAction)buzzTeam1:(id)sender;
-(IBAction)buzzTeam2:(id)sender;

// Back button selector
-(IBAction)returnToMenu:(id)sender;

//function to calculate the number of points scored for a question
- (int) pointScoredWithXSecondsLeft: (int) secondsLeft;

@end
