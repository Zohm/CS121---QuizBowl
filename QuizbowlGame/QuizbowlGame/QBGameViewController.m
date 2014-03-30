//
//  QBGameViewController.m
//  QuizbowlGame
//
//  Created by jarthurcs on 3/8/14.
//  Copyright (c) 2014 HMC_CS121. All rights reserved.
//

#import "QBGameViewController.h"
#import "QBHudView.h"

@interface QBGameViewController ()

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

- (void)setHud:(QBHudView*) hud
{
    _hud = hud;
    // Have the buzzers in the hud select their respective actions
    [hud.buzzer1 addTarget:self action:@selector(actionBuzzTeam1)
          forControlEvents:UIControlEventTouchUpInside];
    [hud.buzzer2 addTarget:self action:@selector(actionBuzzTeam2)
          forControlEvents:UIControlEventTouchUpInside];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    QBHudView *hud = [[QBHudView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self setHud:hud];
    [self.view addSubview:hud];
}



-(void) actionBuzzTeam1
{
    self.hud.score1.text = @"Hurrah!";
}

-(void) actionBuzzTeam2
{
    self.hud.score2.text = @"Woot!";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
