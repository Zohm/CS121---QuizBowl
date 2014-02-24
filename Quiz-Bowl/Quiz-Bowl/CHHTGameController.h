//
//  CHHTGameController.h
//  Quiz-Bowl
//
//  Created by Zohm on 22/02/14.
//  Copyright (c) 2014 Zohm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CHHTQuestion.h"
#import "CHHTQuestionView.h"

@interface CHHTGameController : NSObject

//the view to add game elements to
@property(weak, nonatomic) UIView * gameView;

//the current set of questions
@property(strong, nonatomic) CHHTQuestion * questionSet;

//HUD view
//@property(weak, nonatomic) CHHTHUDView * hud;

//display a new question on the screen
- (void) dealRandomQuestion;

@end
