//
//  QBMainModeEndScreenViewController.h
//  Quiz-Bowl
//
//  Created by Zohm on 27/04/14.
//  Copyright (c) 2014 Zohm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QBMainModeEndScreenViewController : UIViewController

//Values
@property (nonatomic) int scoreTeamA;
@property (nonatomic) int scoreTeamB;

// Buttons

// Labels
@property (weak, nonatomic) IBOutlet UILabel *lblWinningTeam;
@property (weak, nonatomic) IBOutlet UILabel *lblLoosingTeam;


@end