//
//  CHHTPracticeEndScreenViewController.m
//  Quiz-Bowl
//
//  Created by Zohm on 09/03/14.
//  Copyright (c) 2014 Zohm. All rights reserved.
//

#import "CHHTPracticeEndScreenViewController.h"
#import "config.h"

@interface CHHTPracticeEndScreenViewController ()

@end

@implementation CHHTPracticeEndScreenViewController

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
	
    self.lblEndSentence.font = fontHUDBig;
    self.lblInterScore.font = fontHUD;
    self.lblNbQuestions.font = fontHUDBig;
    self.lblScore.font = fontHUDBig;
    self.lblq.font = fontHUDBig;
    self.lblScore.textColor = [UIColor greenColor];
    
    
    self.lblEndSentence.text = @"  You answered correctly to ";
    self.lblInterScore.text = @"   on";
    self.lblScore.text = [NSString stringWithFormat:@"   %d", self.score];
    self.lblNbQuestions.text = [NSString stringWithFormat:@"   %d", self.nbQuestion];
    self.lblq.text = @"  question!";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
