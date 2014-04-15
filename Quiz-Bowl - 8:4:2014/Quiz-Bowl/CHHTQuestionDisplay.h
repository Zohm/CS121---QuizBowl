//
//  CHHTDisplayQuestionView.h
//  Quiz-Bowl
//
//  Created by jarthurcs on 4/13/14.
//  Copyright (c) 2014 Zohm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QBQuestion.h"

@interface CHHTQuestionDisplay : NSObject

@property (weak, nonatomic) UILabel* lblQuestion;

-(instancetype) initWithLabel:(UILabel*) label;

-(void)showQuestion:(QBQuestion*)question;

-(void)showText:(NSString*)text;

-(void)pauseDisplay;

-(void)resumeDisplay;

@end
