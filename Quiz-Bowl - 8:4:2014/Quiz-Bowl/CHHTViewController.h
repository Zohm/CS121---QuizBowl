//
//  CHHTViewController.h
//  Quiz-Bowl
//
//  Created by Zohm on 25/02/14.
//  Copyright (c) 2014 Zohm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CHHTViewController : UIViewController

//button to launch a new game
@property (weak, nonatomic) IBOutlet UIButton *btnNewGame;

//button to launch a game in practice mode
@property (weak, nonatomic) IBOutlet UIButton *btnPractice;

//button to display the high scores page
@property (weak, nonatomic) IBOutlet UIButton *btnHighScores;


@end
