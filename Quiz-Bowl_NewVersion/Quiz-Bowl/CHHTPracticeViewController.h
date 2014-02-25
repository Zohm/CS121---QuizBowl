//
//  CHHTPracticeViewController.h
//  Quiz-Bowl
//
//  Created by Zohm on 25/02/14.
//  Copyright (c) 2014 Zohm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CHHTPracticeViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *btnBack;

@property (weak, nonatomic) IBOutlet UILabel *lblQuestion;

@property (weak, nonatomic) IBOutlet UILabel *lblAnswerA;
@property (weak, nonatomic) IBOutlet UILabel *lblAnswerB;
@property (weak, nonatomic) IBOutlet UILabel *lblAnswerC;
@property (weak, nonatomic) IBOutlet UILabel *lblAnswerD;

@property (weak, nonatomic) IBOutlet UIButton *btnA;
@property (weak, nonatomic) IBOutlet UIButton *btnB;
@property (weak, nonatomic) IBOutlet UIButton *btnC;
@property (weak, nonatomic) IBOutlet UIButton *btnD;

@property (weak, nonatomic) NSMutableArray *questions;
@property (weak,nonatomic) NSString *answer;


@end
