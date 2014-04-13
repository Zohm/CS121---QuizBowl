//
//  QBModifyQuestionViewController.m
//  QuizbowlGame
//
//  Created by jarthurcs on 3/2/14.
//  Copyright (c) 2014 HMC_CS121. All rights reserved.
//

#import "QBModifyQuestionViewController.h"
#import <Parse/Parse.h>

@interface QBModifyQuestionViewController ()

@end

@implementation QBModifyQuestionViewController

#pragma mark - Database methods

-(IBAction)deleteButtonPressed
{
    // Change to button to indicate it has been pressed
    [self.deleteButton setTitle:@"Deleting question" forState:UIControlStateNormal];
    [self.deleteButton setEnabled:NO];
    [self.question deleteInBackground];
    
    // Delete the question object from Parse.
    [self.delegate questionSubmitted];
}

-(IBAction)submitButtonPressed
{
    // Change the button to indicate it has been pressed
    [self.submitButton setTitle:@"Saving changes" forState:UIControlStateNormal];
    [self.submitButton setEnabled:NO];
    
    // Get changes to the question object from the textfields
    [self.question setObject:[self.titleTextField text] forKey:@"title"];
    [self.question setObject:[self.questionTextView text] forKey:@"question"];
    [self.question setObject:[self.answerTextView text] forKey:@"answer"];
    
    // Save the modified question object in Parse
    [self.question saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            [self.delegate questionSubmitted]; // Dismiss the viewController upon success
        }
    }];}

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

/*
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}*/


@end
