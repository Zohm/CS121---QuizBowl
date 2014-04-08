//
//  CHHTPracticeEndScreenViewController.h
//  Quiz-Bowl
//
//  Created by Zohm on 09/03/14.
//  Copyright (c) 2014 Zohm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CHHTPracticeEndScreenViewController : UIViewController

//Values
@property (nonatomic) int score;
@property (nonatomic) int nbQuestion;


// Buttons
@property (weak, nonatomic) IBOutlet UIButton *btnMenu;
@property (weak, nonatomic) IBOutlet UIButton *btnReplay;

// Labels
@property (weak, nonatomic) IBOutlet UILabel *lblScore;
@property (weak, nonatomic) IBOutlet UILabel *lblEndSentence;
@property (weak, nonatomic) IBOutlet UILabel *lblNbQuestions;
@property (weak, nonatomic) IBOutlet UILabel *lblq;
@property (weak, nonatomic) IBOutlet UILabel *lblInterScore;


@end
