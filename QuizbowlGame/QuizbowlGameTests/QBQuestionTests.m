//
//  QBQuestionTests.m
//  QuizbowlGame
//
//  Created by jarthurcs on 3/7/14.
//  Copyright (c) 2014 HMC_CS121. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <regex.h>
#import "QBQuestion.h"

@interface QBQuestionTests : XCTestCase

@property QBQuestion* nilquestion;

@property QBQuestion* question;

@property QBQuestion* multipartkeyquestion;

@property NSDictionary* answer;

@end

@implementation QBQuestionTests

- (void)setUp
{
    [super setUp];
    
    // A question that has no answer (answer set to nil)
    self.nilquestion = [[QBQuestion alloc] init];
    
    // A question with multiple keys and some keys with extras
    self.question = [[QBQuestion alloc] init];
    NSArray* answers = [[NSArray alloc] initWithObjects:@"cat", @"feline", @"felix catus", nil];
    NSArray* extras = [[NSArray alloc] initWithObjects:@"house, domestic", @"", @"", nil];
    self.answer = [[NSDictionary alloc] initWithObjects:extras forKeys:answers];
    self.question.answer = self.answer;
    
    // A question with keys that have multiple parts
    self.multipartkeyquestion = [[QBQuestion alloc] init];
    answers = [[NSArray alloc] initWithObjects:@"P, NP", nil];
    extras = [[NSArray alloc] initWithObjects:@"vs, or, and, vs.", nil];
    self.multipartkeyquestion.answer = [[NSDictionary alloc] initWithObjects:extras forKeys:answers];
}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    [super tearDown];
}

-(void)testCheckAnswerDoesNotChangeAnswer
{
    [self.question doesMatchAnswer:@"house cat"];
    XCTAssertEqual(self.answer, self.question.answer, @"Checking against the answer does not change the answer");
}

-(void)testEmptyStringMatchesNoAnswer
{
    XCTAssertFalse([self.question doesMatchAnswer:@""], @"The empty string should match no answer unless it is explictly an answer.");
}

-(void)testReturnNoWhenAnswerIsNil
{
    XCTAssertFalse([self.nilquestion doesMatchAnswer:@"cat"], @"No answer is correct if a question has no answer");
}

-(void)testExactMatchShouldReturnYes
{
    XCTAssertTrue([self.question doesMatchAnswer:@"cat"], @"An exact match should return true");
    XCTAssertTrue([self.question doesMatchAnswer:@"feline"], @"An exact match should return true");
    XCTAssertTrue([self.question doesMatchAnswer:@"felix catus"], @"An exact match should return true");
}

-(void)testMatchWithMultipartKeyShouldReturnYes
{
    XCTAssertTrue([self.multipartkeyquestion doesMatchAnswer:@"P vs. NP"], @"A correct answer matched against a key with multiple parts should return yes");
    XCTAssertTrue([self.multipartkeyquestion doesMatchAnswer:@"NP vs. P"], @"A correct answer matched against a key with multiple parts should return yes");
}

-(void)testAugmentedAnswerShouldReturnYes
{
    XCTAssertTrue([self.question doesMatchAnswer:@"house cat"], @"A match with extra acceptable words should return true");
    XCTAssertTrue([self.question doesMatchAnswer:@"domestic cat"], @"A match with extra acceptable words should return true");
}

-(void)testExtraneousAnswerShouldReturnNo
{
    XCTAssertFalse([self.question doesMatchAnswer:@"sabertooth cat"], @"A match with unacceptable extra words should return false");
}

@end
