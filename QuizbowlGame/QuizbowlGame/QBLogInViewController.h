//
//  QBLogInViewController.h
//  QuizbowlGame
//
//  Created by jarthurcs on 2/23/14.
//  Copyright (c) 2014 HMC_CS121. All rights reserved.
//

#import <Parse/Parse.h>

@interface QBLogInViewController :
UIViewController <PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate>

@property (nonatomic, strong) IBOutlet UILabel *welcomeLabel;

- (IBAction)logOutButtonTapAction:(id)sender;

@end

