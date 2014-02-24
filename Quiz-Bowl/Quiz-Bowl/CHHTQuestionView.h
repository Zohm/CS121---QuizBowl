//
//  CHHTQuestionView.h
//  Quiz-Bowl
//
//  Created by Zohm on 23/02/14.
//  Copyright (c) 2014 Zohm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CHHTQuestionView : UIImageView


@property(strong, nonatomic, readonly) NSString * question;

- (instancetype) initWithQuestion: (NSString *) question;

@end
