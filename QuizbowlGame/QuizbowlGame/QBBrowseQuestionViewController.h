//
//  QBBrowseQuestionViewController.h
//  QuizbowlGame
//
//  Created by jarthurcs on 2/26/14.
//  Copyright (c) 2014 HMC_CS121. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "QBCreateQuestionViewController.h"

@interface QBBrowseQuestionViewController : UITableViewController<QBCreateQuestionViewControllerDelegate>

@property (strong, nonatomic) NSArray* questionArray;

@end
