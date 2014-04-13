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

@interface QBGameController : NSObject

@property (strong, nonatomic) QBHudView* hud;

@property (strong, nonatomic) QBEnterAnswerView* answerView;

@property (strong, nonatomic) QBLevel* level;

-(void) beginGame; 

@end
