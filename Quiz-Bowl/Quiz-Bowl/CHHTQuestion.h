//
//  CHHTQuestion.h
//  Quiz-Bowl
//
//  Created by Zohm on 22/02/14.
//  Copyright (c) 2014 Zohm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CHHTQuestion : NSObject

//property from the .plist file
//will later be handle by a database
@property(assign, nonatomic) int pointPerQuestion;
@property(assign, nonatomic) int timeToSolve;
@property(strong, nonatomic) NSArray * questions;

//method to load the ,plist file and load the model
+ (instancetype) questionInit;

@end
