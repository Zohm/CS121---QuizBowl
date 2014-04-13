//
//  QBGameViewController.h
//  QuizbowlGame
//
//  Created by jarthurcs on 3/8/14.
//  Copyright (c) 2014 HMC_CS121. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QBHudView.h"

@interface QBGameViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *buzzer1;

@property (weak, nonatomic) IBOutlet UIButton *buzzer2;

@property (weak, nonatomic) IBOutlet UILabel *score1;

@property (weak, nonatomic) IBOutlet UILabel *score2; 

@end
