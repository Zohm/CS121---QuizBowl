//
//  QBHudView.m
//  QuizbowlGame
//
//  Created by jarthurcs on 3/8/14.
//  Copyright (c) 2014 HMC_CS121. All rights reserved.
//

#import "QBHudView.h"

@implementation QBHudView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        CGFloat height = CGRectGetHeight(frame);
        CGFloat width = CGRectGetWidth(frame);
        CGFloat margin = height/5;
        
        self.buzzer1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.buzzer1.frame = CGRectMake(width/2, margin, 100, 100);
        [self.buzzer1 setTitle:@"Buzzer" forState:UIControlStateNormal];
        [self addSubview:self.buzzer1];

        self.buzzer2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.buzzer2.frame = CGRectMake(width/2, height - margin, 100, 100);
        [self.buzzer2 setTitle:@"Buzzer" forState:UIControlStateNormal];
        [self addSubview:self.buzzer2];
        
        self.score1 = [[UILabel alloc] initWithFrame:CGRectMake(width/4, height/4, width, height/4)];
        self.score1.text = @"Points:";
        [self addSubview:self.score1];

        self.score2 = [[UILabel alloc] initWithFrame:CGRectMake(width/4, height*1/3, width, height/4)];
        self.score2.text = @"Points:";
        [self addSubview:self.score2];
        
        self.question = [[UILabel alloc] initWithFrame:CGRectMake(width/2, height/2, width, height/4)];
        [self addSubview:self.question];
        
        self.timer = [[UILabel alloc] initWithFrame:CGRectMake(width/2, 3*height/4, width/3, height/3)];
        [self addSubview:self.timer]; 
    }
    return self;
}

-(id)hitTest:(CGPoint) point withEvent:(UIEvent *)event
{
    //Find the view that would normally handle this touch event.
    UIView* hitView = (UIView*)[super hitTest:point withEvent:event];
    
    //Forward touch events to buttons, otherwise, let event through to next layer. 
    if ([hitView isKindOfClass:[UIButton class]]) {
        return hitView;
    }
    return NULL;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
