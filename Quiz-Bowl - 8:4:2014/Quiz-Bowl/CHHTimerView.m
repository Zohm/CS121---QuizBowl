//
//  CHHTimerView.m
//  Quiz-Bowl
//
//  Created by Zohm on 03/03/14.
//  Copyright (c) 2014 Zohm. All rights reserved.
//

#import "CHHTimerView.h"
#import "config.h"

@implementation CHHTimerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        //make the background transparent,
        self.backgroundColor = [UIColor clearColor];
        //init the font of the timer
        self.font = fontHUDBig;
    }
    return self;
}

- (void) setSeconds: (int) seconds
{
    //set the label text property with the mm:ss format,
    self.text = [NSString stringWithFormat: @" %02.f : %02i", round(seconds / 60), seconds % 60 ];
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
