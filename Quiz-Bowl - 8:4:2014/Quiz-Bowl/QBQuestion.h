//
//  QBQuestion.h
//  QuizbowlGame
//
//  Created by jarthurcs on 3/7/14.
//  Copyright (c) 2014 HMC_CS121. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QBQuestion : NSObject

@property NSString* question;

@property NSDictionary* answer;

-(instancetype) initWithPair:(NSArray* ) pair;

-(BOOL) doesMatchAnswer:(NSString* ) answer;

@end
