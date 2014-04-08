//
//  CHHTHUDView.h
//  Quiz-Bowl
//
//  Created by Zohm on 03/03/14.
//  Copyright (c) 2014 Zohm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CHHTimerView.h"
#import "CHHTCounterLabelView.h"

@interface CHHTHUDView : UIView

@property(strong, nonatomic) CHHTimerView *timer;
@property (strong, nonatomic) CHHTCounterLabelView * gamePointsTeamA;
@property (strong, nonatomic) CHHTCounterLabelView * gamePointsTeamB;

+ (instancetype) viewWithRect: (CGRect) r;

// SECOND LABEL SCORE TO ADD FOR TEAM B!!!!

@end
