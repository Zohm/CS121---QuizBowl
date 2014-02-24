//
//  CHHTViewController.m
//  Quiz-Bowl
//
//  Created by Zohm on 23/02/14.
//  Copyright (c) 2014 Zohm. All rights reserved.
//

#import "CHHTViewController.h"
#import "config.h"
#import "CHHTQuestion.h"
#import "CHHTGameController.h"

@interface CHHTViewController ()

@property (strong, nonatomic) CHHTGameController * controller;

@end

@implementation CHHTViewController

/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
 */

//setup the view and instantiate the game controller
- (void)viewDidLoad
{
    [super viewDidLoad];
	
    //init if the questionSet
    CHHTQuestion * questionSet = [CHHTQuestion questionInit];
    //NSLog(@"questions: %@", questionSet.questions);
   
    //init the view
    UIView * gameLayer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, ScreenHeight)];
    [self.view addSubview: gameLayer];
    self.controller.gameView = gameLayer;
    
    //init HUD here
    //
    
    self.controller.questionSet = questionSet;
    [self.controller dealRandomQuestion];
}


- (instancetype) initWithCoder:(NSCoder *) decoder
{
    self = [super initWithCoder: decoder];
    if (self != nil)
    {
        //create a game controller
        self.controller = [[CHHTGameController alloc] init];
    }
    
    return self;
}

/*
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
 */



@end
