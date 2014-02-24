//
//  CHHTQuestionView.m
//  Quiz-Bowl
//
//  Created by Zohm on 23/02/14.
//  Copyright (c) 2014 Zohm. All rights reserved.
//

#import "CHHTQuestionView.h"

@implementation CHHTQuestionView

- (id)initWithFrame:(CGRect)frame
{
    NSAssert(NO, @"Use initWithQuestion instead");
    return nil;
}

- (instancetype) initWithQuestion: (NSString *) question
{
    //add the question
    UILabel * lblQuestion = [[UILabel alloc] initWithFrame: self.bounds];
    lblQuestion.textAlignment = NSTextAlignmentCenter;
    lblQuestion.textColor = [UIColor blackColor];
    lblQuestion.backgroundColor = [UIColor clearColor];
    lblQuestion.text = question;
    //lblQuestion.font = [UIFont fontWithName: @"" size: 78.0];
    [self addSubview:lblQuestion];

    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
