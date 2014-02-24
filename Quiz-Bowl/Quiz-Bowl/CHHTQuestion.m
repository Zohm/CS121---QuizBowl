//
//  CHHTQuestion.m
//  Quiz-Bowl
//
//  Created by Zohm on 22/02/14.
//  Copyright (c) 2014 Zohm. All rights reserved.
//

#import "CHHTQuestion.h"

@implementation CHHTQuestion

+ (instancetype) questionInit
{
    //get the file
    NSString * filename = @"questions.plist";
    NSString * path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:filename];
    
    //load it (.plist file)
    NSDictionary * questionDict = [NSDictionary dictionaryWithContentsOfFile: path];
    
    //test if file is loaded
    NSAssert(questionDict, @"question config not found");
    
    //create question instance
    CHHTQuestion * q = [[CHHTQuestion alloc] init];
    
    //init object from the dictionary
    q.pointPerQuestion = [questionDict[@"pointPerQuestion"] intValue];
    q.timeToSolve = [questionDict[@"timeToSolve"] intValue];
    q.questions = questionDict[@"timeToSolve"];
    
    return q;
}

@end
