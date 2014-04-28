//
//  QBMainModeEndScreenViewController.m
//  Quiz-Bowl
//
//  Created by Zohm on 27/04/14.
//  Copyright (c) 2014 Zohm. All rights reserved.
//

#import "QBMainModeEndScreen.h"
#import "config.h"

@interface QBMainModeEndScreenViewController ()

@end

@implementation QBMainModeEndScreenViewController

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
	
    self.lblWinningTeam.font = fontHUDBig;
    self.lblLoosingTeam.font = fontHUD;

    self.lblWinningTeam.textColor = [UIColor greenColor];
	self.lblLoosingTeam.textColor = [UIColor redColor];
    
	//if Team A wins
	if(self.scoreTeamA > self.scoreTeamB)
	{
		self.lblWinningTeam.text = [NSString stringWithFormat:@" Team A wins with %d points! Good Job Team A!", self.scoreTeamA];
		self.lblLoosingTeam.text = [NSString stringWithFormat:@" Team B scored only %d points! Maybe next time!", self.scoreTeamB];
	}
	//if Team B wins
	else if (self.scoreTeamA < self.scoreTeamB)
	{
		self.lblWinningTeam.text = [NSString stringWithFormat:@" Team B wins with %d points! Good Job Team B!", self.scoreTeamB];
		self.lblLoosingTeam.text = [NSString stringWithFormat:@" Team A scored only %d points! Maybe next time!", self.scoreTeamA];
	}
	//if it's a draw
	else 
	{
		self.lblWinningTeam.text = [NSString stringWithFormat:@" Both teams scored %d. It's a draw!", self.scoreTeamA];
		self.lblLoosingTeam.text = @" You should play again to see which team is the best!";
	}
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
