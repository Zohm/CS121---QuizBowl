//
//  CHHTPracticeViewController.m
//  Quiz-Bowl
//
//  Created by Zohm on 25/02/14.
//  Copyright (c) 2014 Zohm. All rights reserved.
//

#import "CHHTPracticeViewController.h"

@interface CHHTPracticeViewController ()

@end

@implementation CHHTPracticeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    NSString *path = [[NSBundle mainBundle] pathForResource:@"PracticeQuestions" ofType:@"plist"];
    NSDictionary *tempDict = [[NSDictionary alloc] initWithContentsOfFile:path];
    self.questions = [tempDict objectForKey:@"Questions"];
    
    //JE SUIS ICI - 6min52
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
