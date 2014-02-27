//
//  QBCreateQuestionViewController.h
//  QuizbowlGame
//
//  Created by jarthurcs on 2/24/14.
//  Copyright (c) 2014 HMC_CS121. All rights reserved.

#import <UIKit/UIKit.h>

@interface QBCreateQuestionViewController: UIViewController

@property (weak, nonatomic) IBOutlet UITextField *titleTextField;

@property (weak, nonatomic) IBOutlet UITextView *questionTextView;

@property (weak, nonatomic) IBOutlet UITextView *answerTextView;

-(IBAction)submitButtonPressed;

@end