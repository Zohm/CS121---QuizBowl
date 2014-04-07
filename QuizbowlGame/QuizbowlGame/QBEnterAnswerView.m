//
//  QBEnterAnswerView.m
//  QuizbowlGame
//
//  Created by jarthurcs on 3/29/14.
//  Copyright (c) 2014 HMC_CS121. All rights reserved.
//

#import "QBEnterAnswerView.h"

@implementation QBEnterAnswerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        CGFloat height = CGRectGetHeight(frame);
        CGFloat width = CGRectGetWidth(frame);
        UITextField* answerField = [[UITextField alloc] initWithFrame:CGRectMake(width/2, height/2, 200, 100)];
        answerField.text = @"Hello";
        answerField.layer.borderWidth = 2.0f;
        answerField.layer.borderColor = [[[UIColor grayColor] colorWithAlphaComponent:0.5f] CGColor];
        answerField.layer.cornerRadius = 8.0f;
        answerField.clipsToBounds = YES;
        self.answerField = answerField;
        [self addSubview: answerField];
    }
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
