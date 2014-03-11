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
        // Just use frame for now, figure out dimensions later
        self.buzzer1 = [[UIButton alloc] initWithFrame:frame];
        self.buzzer2 = [[UIButton alloc] initWithFrame:frame];
        [self addSubview:self.buzzer1];
        [self addSubview:self.buzzer2];
        
        self.score1 = [[UILabel alloc] initWithFrame:frame];
        self.score2 = [[UILabel alloc] initWithFrame:frame];
        [self addSubview:self.score1];
        [self addSubview:self.score2];
    }
    return self;
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
