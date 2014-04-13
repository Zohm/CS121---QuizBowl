//
//  CHHTCounterLabelView.h
//  Quiz-Bowl
//
//  Created by Zohm on 07/04/14.
//  Copyright (c) 2014 Zohm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CHHTCounterLabelView : UILabel

@property (assign, nonatomic) int value;

+(instancetype)labelWithFont:(UIFont*)font frame:(CGRect)r andValue:(int)v;

-(void)countTo:(int)to withDuration:(float)t;

@end
