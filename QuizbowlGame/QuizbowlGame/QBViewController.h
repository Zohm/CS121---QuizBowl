//
//  QBViewController.h
//  QuizbowlGame
//
//  Created by jarthurcs on 3/5/14.
//  Copyright (c) 2014 HMC_CS121. All rights reserved.
//

#import "QBCreateQuestionViewController.h"

@interface UIViewController (withInitializers)

// These methods are for convenience. Using Objective-C categories makes sense since
// many of the view controllers here will use these methods to initialize themselves
// with the interface builder. 

+(id) initWithXib;

+(id) initWithStoryboard: (NSString*)storyboard andIdentifier:(NSString*) identifier;

@end
