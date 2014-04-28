//
//  QBGameController.h
//  QuizbowlGame
//
//  Created by jarthurcs on 3/29/14.
//  Copyright (c) 2014 HMC_CS121. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QBHudView.h"
#import "QBEnterAnswerView.h"
#import "QBQuestion.h"
#import "QBLevel.h" 
#import "CHHTQuestionDisplay.h"
#import "CHHTHUDView.h"
#import "QBGameControllerDelegate.h"
#import "QBAudioController.h"
#import "config.h"

@interface QBGameController : NSObject

@property (weak, nonatomic) UIButton* buzzer1;

@property (weak, nonatomic) UIButton* buzzer2;

@property (weak, nonatomic) UITextField* answerField;

@property (weak, nonatomic) CHHTHUDView* hud; 

@property (strong, nonatomic) CHHTQuestionDisplay* questionDisplay; 

@property (strong, nonatomic) QBLevel* level;

@property (weak, nonatomic) id<QBGameControllerDelegate> viewController;

@property (strong, nonatomic) QBAudioController* audioController;

-(NSInteger) getScoreForTeam:(NSInteger)team;

-(void) beginGame;

-(void) actionBuzzTeam:(NSInteger)teamNumber;

@end
