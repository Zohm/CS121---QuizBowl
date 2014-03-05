//
//  QBViewController.m
//  QuizbowlGame
//
//  Created by jarthurcs on 3/5/14.
//  Copyright (c) 2014 HMC_CS121. All rights reserved.
//

#import "QBViewController.h"

@implementation UIViewController (withInitializers)

+(id)initWithXib
{
    NSString *nibName = NSStringFromClass([self class]);
    return [[self alloc] initWithNibName:nibName bundle:nil];
}

+(id) initWithStoryboard:(NSString *)storyboard andIdentifier:(NSString *)identifier
{
    UIStoryboard* Storyboard = [UIStoryboard storyboardWithName:storyboard bundle:nil];
    return [Storyboard instantiateViewControllerWithIdentifier:identifier];
}

@end
