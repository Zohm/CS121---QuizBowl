//
//  QBModifyQuestionViewController.h
//  QuizbowlGame
//
//  Created by jarthurcs on 3/2/14.
//  Copyright (c) 2014 HMC_CS121. All rights reserved.
//

#import "QBCreateQuestionViewController.h"

@interface QBModifyQuestionViewController : QBCreateQuestionViewController

@property (weak, nonatomic) IBOutlet UIButton *deleteButton;

-(IBAction)deleteButtonPressed;

@end
