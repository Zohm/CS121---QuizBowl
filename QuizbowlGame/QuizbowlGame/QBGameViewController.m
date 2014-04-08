//
//  QBGameViewController.m
//  QuizbowlGame
//
//  Created by jarthurcs on 3/8/14.
//  Copyright (c) 2014 HMC_CS121. All rights reserved.
//

#import "QBGameViewController.h"
#import "QBGameController.h"
#import "QBHudView.h"

@interface QBGameViewController ()

@property (strong, nonatomic) QBGameController* controller;

@end

@implementation QBGameViewController

#pragma mark - setup

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    // Initialize the GameController
    self.controller = [[QBGameController alloc] init];
    
    // Set up the answer view
    QBEnterAnswerView* answerView = [[QBEnterAnswerView alloc]
                                     initWithFrame:[[UIScreen mainScreen] bounds]];
    answerView.hidden = YES; 
    self.controller.answerView = answerView;
    [self.view addSubview:answerView];
    
    
    // Set up the HUD
    QBHudView *hud = [[QBHudView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.controller setHud:hud];
    [self.view addSubview:hud];
    
    // Set up the level
    self.controller.level = [QBLevel levelWithName:@"testquestions"];
    
    // Start the game 
    [self.controller beginGame];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
