//
//  QBHudView.h
//  QuizbowlGame
//
//  Created by jarthurcs on 3/8/14.
//  Copyright (c) 2014 HMC_CS121. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QBHudView : UIView

@property UIButton* buzzer1;

@property UIButton* buzzer2;

@property UILabel* score1;

@property UILabel* score2;

//Replace this with its own view later
@property UILabel* timer;

//Later replace this with a view for displaying questions
@property UILabel* question; 

@end
