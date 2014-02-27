//
//  QBCreateQuestionViewController.m
//  QuizbowlGame
//
//  Created by jarthurcs on 2/24/14.
//  Copyright (c) 2014 HMC_CS121. All rights reserved.
//

#import "QBCreateQuestionViewController.h"
#import <Parse/Parse.h>

@implementation QBCreateQuestionViewController

#pragma mark - View lifecycle

- (void)loadView
{
    [super loadView];
}


#pragma mark - Button handlers

- (IBAction) submitButtonPressed
{
    // Create a new Post object and create relationship with PFUser
    PFObject *newPost = [PFObject objectWithClassName:@"QBQuestion"];
    // Extract text from textView
    [newPost setObject:[self.titleTextField text] forKey:@"title"];
    [newPost setObject:[self.questionTextView text] forKey:@"question"];
    [newPost setObject:[self.answerTextView text] forKey:@"answer"];
    [newPost setObject:[PFUser currentUser] forKey:@"author"]; // One-to-Many relationship created here!
    
    // Set ACL permissions for added security
    PFACL *postACL = [PFACL ACLWithUser:[PFUser currentUser]];
    [postACL setPublicReadAccess:YES];
    [newPost setACL:postACL];
    
    // Save new Post object in Parse
    [newPost saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            [self dismissViewControllerAnimated:YES completion:nil]; // Dismiss the viewController upon success
        }
    }];
}

@end

