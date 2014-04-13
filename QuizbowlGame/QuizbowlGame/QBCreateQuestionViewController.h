//
//  QBCreateQuestionViewController.h
//  QuizbowlGame
//
//  Created by jarthurcs on 2/24/14.
//  Copyright (c) 2014 HMC_CS121. All rights reserved.

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@protocol QBCreateQuestionViewControllerDelegate <NSObject>

@required

-(void) questionSubmitted;

@end

@interface QBCreateQuestionViewController: UIViewController

@property (strong, nonatomic) IBOutlet UIView *view;

@property (strong, nonatomic) id delegate;

@property (weak, nonatomic) IBOutlet UITextField *titleTextField;

@property (weak, nonatomic) IBOutlet UITextView *questionTextView;

@property (weak, nonatomic) IBOutlet UITextView *answerTextView;

@property (weak, nonatomic) IBOutlet UIButton *submitButton;

@property PFObject* question;

// Factory method to initialize with textViews and textFields populated with question attributes
-(id)initWithQuestion:(PFObject* )question;

-(IBAction)submitButtonPressed;

@end