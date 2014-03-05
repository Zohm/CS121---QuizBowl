//
//  QBCreateQuestionViewController.m
//  QuizbowlGame
//
//  Created by jarthurcs on 2/24/14.
//  Copyright (c) 2014 HMC_CS121. All rights reserved.
//

#import "QBCreateQuestionViewController.h"
#import <Parse/Parse.h>

@interface QBCreateQuestionViewController()


@end

@implementation QBCreateQuestionViewController

#pragma mark - Factory method

-(id)initWithQuestion:(PFObject *)question
{
//    QBCreateQuestionViewController* viewController = [self initWithXibAndDelegate:delegate];
//    viewController.question = question;
//    return viewController;
    self.question = question;
    return self;
}

+(id)initWithStoryboard
{
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    return [storyboard instantiateViewControllerWithIdentifier:@"create"];
}

-(id)addDelegate:(id)delegate
{
    self.delegate = delegate;
    return self;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Populate textFields with question attributes
    if (self.question) {
        self.titleTextField.text = [self.question objectForKey:@"title"];
        self.questionTextView.text = [self.question objectForKey:@"question"];
        self.answerTextView.text = [self.question objectForKey:@"answer"];
    } else {
        self.titleTextField.text = @"Give your question a name";
        self.questionTextView.text = @"Write your question";
        self.answerTextView.text = @"Write the answer";
    }
    
}


#pragma mark - Button handlers

- (IBAction) submitButtonPressed
{
    // Change the button text to indicate that the question is being created
    [self.submitButton setTitle:@"Submitting question" forState:UIControlStateNormal];
    [self.submitButton setEnabled:NO];
    
    // Create a new Post object and create relationship with PFUser
    PFObject *newPost = [PFObject objectWithClassName:@"QBQuestion"];
    // Extract text from textView
    [newPost setObject:[self.titleTextField text] forKey:@"title"];
    [newPost setObject:[self.questionTextView text] forKey:@"question"];
    [newPost setObject:[self.answerTextView text] forKey:@"answer"];
    [newPost setObject:[PFUser currentUser] forKey:@"author"];
    
    // Set ACL permissions for added security
    PFACL *postACL = [PFACL ACLWithUser:[PFUser currentUser]];
    [postACL setPublicReadAccess:YES];
    [newPost setACL:postACL];
    
    // Save new question object in Parse
    [newPost saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            [self.delegate questionSubmitted]; // Dismiss the viewController upon success
        }
    }];
}

@end

