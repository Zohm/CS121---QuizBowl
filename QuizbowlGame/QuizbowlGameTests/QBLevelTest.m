//
//  QBLevelTest.m
//  QuizbowlGame
//
//  Created by jarthurcs on 3/30/14.
//  Copyright (c) 2014 HMC_CS121. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "QBLevel.h"

@interface QBLevelTest : XCTestCase

@end

@implementation QBLevelTest

- (void)setUp
{
    [super setUp];
    // Put setup code here; it will be run once, before the first test case.
}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    [super tearDown];
}

- (void)testOneTossUp
{
    QBLevel* oneTossUpLevel = [QBLevel levelWithName:@"test1tossup"];
    XCTAssertTrue([oneTossUpLevel hasNextTossUp], @"Should detect when there are more toss up questions.");
    XCTAssertFalse([oneTossUpLevel hasNextBonus], @"Should detect when there are no more bonus questions.");
    
    QBQuestion* tossup = [[oneTossUpLevel getNextTossUp].questions objectAtIndex:0];
    XCTAssertTrue([tossup.question isEqualToString:@"What is two plus two?"], @"Should return the correct tossup question.");
    XCTAssertTrue([[[tossup.answer allKeys] objectAtIndex:0] isEqualToString:@"four"], @"Should return the correct tossup question.");
    
    XCTAssertFalse([oneTossUpLevel hasNextTossUp], @"Getting a tossup should update the level.");
}

- (void)testOneBonus
{
    QBLevel* oneBonusLevel = [QBLevel levelWithName:@"test1bonus"];
    XCTAssertTrue([oneBonusLevel hasNextBonus], @"Should report that the level has a bonus question.");
    XCTAssertFalse([oneBonusLevel hasNextTossUp], @"Should report that the level does not have a tossup question.");
    
    QBRound* bonusRound = [oneBonusLevel getNextBonus];
    NSString* intro = bonusRound.intro;
    QBQuestion* bonus1 = [bonusRound getNextQuestion];
    QBQuestion* bonus2 = [bonusRound getNextQuestion];
    QBQuestion* bonus3 = [bonusRound getNextQuestion];
    
    XCTAssertTrue([intro isEqualToString:@"Math for ten points each."], @"Should return correct intro.");
    XCTAssertTrue([bonus1.question isEqualToString:@"What is two plus two?"], @"Should return correct question.");
    XCTAssertTrue([bonus2.question isEqualToString:@"What is two plus eight?"], @"Should return correct question.");
    XCTAssertTrue([bonus3.question isEqualToString:@"What is two times six?"], @"Should return correct question.");
    XCTAssertFalse([bonusRound hasNextQuestion], @"Should report that there are no questions left.");
    
    XCTAssertTrue([bonus1 doesMatchAnswer:@"four"], @"Should return correct answer.");
    XCTAssertTrue([bonus2 doesMatchAnswer:@"ten"], @"Should return correct answer.");
    XCTAssertTrue([bonus3 doesMatchAnswer:@"twelve"], @"Should return correct answer.");
}

- (void)testOneTossUpOneBonus
{
    
}

-(void)testTwoTossUps
{
    
}

-(void)testTwoBonuses
{
    
}

@end
