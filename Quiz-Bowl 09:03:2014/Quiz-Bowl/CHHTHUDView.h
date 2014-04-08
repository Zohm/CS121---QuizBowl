//
//  CHHTHUDView.h
//  Quiz-Bowl
//
//  Created by Zohm on 03/03/14.
//  Copyright (c) 2014 Zohm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CHHTimerView.h"

@interface CHHTHUDView : UIView

@property(strong, nonatomic) CHHTimerView *timer;

+ (instancetype) viewWithRect: (CGRect) r;

@end
