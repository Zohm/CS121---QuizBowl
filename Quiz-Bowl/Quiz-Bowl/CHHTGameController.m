//
//  CHHTGameController.m
//  Quiz-Bowl
//
//  Created by Zohm on 22/02/14.
//  Copyright (c) 2014 Zohm. All rights reserved.
//

#import "CHHTGameController.h"
#import "config.h"

@implementation CHHTGameController
{
    NSMutableArray * textZone;
}

- (void) dealRandomQuestion
{
    //verif is the question set is loaded
    NSAssert(self.questionSet.questions, @"no set of qestions loaded");
    
    //generate a random question
    int randomIndex = arc4random()%[self.questionSet.questions count];
    NSArray * qPair = self.questionSet.questions[randomIndex];
    
    //get the question and its answer from the array randomly selected
    NSString * ques = qPair[0];
    NSString * answer = qPair[1];
    
    //print in consol to test if correctly loaded
    NSLog(@"question: %@", ques);
    NSLog(@"answer: %@", answer);
    
    //display question
    /*
    textZone = [NSMutableArray arrayWithCapacity: [ques length]];
    CHHTQuestionView * q = [[CHHTQuestionView alloc] initWithQuestion: ques];
    q.center = CGPointMake(screenWidth/3, ScreenHeight/2);
    
    [self.gameView addSubview: q];
    [textZone addObject: q];
     */
    
    
    //more initialieation to do here
}

@end
