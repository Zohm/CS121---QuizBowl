//
//  CHHTCounterLabelView.m
//  Quiz-Bowl
//
//  Created by Zohm on 07/04/14.
//  Copyright (c) 2014 Zohm. All rights reserved.
//

#import "CHHTCounterLabelView.h"

@implementation CHHTCounterLabelView
{
    int endValue;
    double delta;
}

//create an instance of the counter label
+(instancetype)labelWithFont:(UIFont*)font frame:(CGRect)r andValue:(int)v
{
    CHHTCounterLabelView * label = [[CHHTCounterLabelView alloc] initWithFrame:r];
    if (label!=nil) {
        //initialization
        label.backgroundColor = [UIColor clearColor];
        label.font = font;
        label.value = v;
    }
    return label;
}

//update the label's text
-(void)setValue:(int)value
{
    _value = value;
    self.text = [NSString stringWithFormat:@" %i", self.value];
}

//increment/decrement method
-(void)updateValueBy:(NSNumber*)valueDelta
{
    //Update the property
    self.value += [valueDelta intValue];
    
    //Check for reaching the end value
    if ([valueDelta intValue] > 0)
    {
        if (self.value > endValue)
        {
            self.value = endValue;
            return;
        }
    }
    else //in case we need to take point off, we need to count down. Not used yet but present for futur implementation,
    {
        if (self.value < endValue)
        {
            self.value = endValue;
            return;
        }
    }
    
    //If new score not reach yet, do the function again
    [self performSelector:@selector(updateValueBy:) withObject:valueDelta afterDelay:delta];
}

//count to a given value
-(void)countTo:(int)to withDuration:(float)t
{
    //Detect the time for the animation
    delta = t/((abs(to - self.value) + 1)/1);
    //make sure the counter does no go to fast, which would prevent the user to correctly see the numbers changing.
    if (delta < 0.1) delta = 0.1;
    
    //Set the end value
    endValue = to;
    
    //Cancel previous scheduled actions. Protect from overlapping actions,
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    
    //Detect which way counting goes
    if (to-self.value>0)
    {
        //Count up
        [self updateValueBy: @1];
    }
    else
    {
        //Count down
        [self updateValueBy: @-1];
    }
}


@end
