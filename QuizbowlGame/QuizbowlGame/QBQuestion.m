//
//  QBQuestion.m
//  QuizbowlGame
//
//  Created by jarthurcs on 3/7/14.
//  Copyright (c) 2014 HMC_CS121. All rights reserved.
//

#import "QBQuestion.h"

@implementation QBQuestion

#pragma mark - helper functions

// Returns the range of the first match of the given key to a string.
-(NSRange)matchKey:(NSString*) key toString:(NSString*) string
{
    // This regular expression matches the key if the key appears in the string
    // as its own word and not part of a word. This means the key needs to be surrounded
    // by either whitespace or the beginning or end of the string. 
    NSString* pattern = [NSString stringWithFormat:@"(^|\\s)%@(\\s|$)", key];
    NSRegularExpression* regex = [NSRegularExpression regularExpressionWithPattern:pattern
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:nil];
    return [regex rangeOfFirstMatchInString:string
                                    options:0
                                      range:NSMakeRange(0, [string length])];
}

// Checks that the all the parts of a key are contained in the string. Parts are separated by commas.
-(BOOL) string:(NSString*) string matchesKey:(NSString*)key
{
    NSArray* keyParts = [key componentsSeparatedByString:@", "];
    for (NSString* keyPart in keyParts) {
        
        NSRange match = [self matchKey:keyPart toString:string];
        // The key part is not in the string
        if (NSEqualRanges(match, NSMakeRange(NSNotFound, 0))) {
            NSLog(@"No match");
            return NO;
        }
    }
    return YES;
}

// Checks that the string contains no parts other than those in the extras
-(BOOL) string:(NSString*) string matchesExtras:(NSString*)extras
{
    NSArray* extraParts = [extras componentsSeparatedByString:@", "];
    for (NSString* extra in extraParts) {
        
        NSRange match = [self matchKey:extra toString:string];
        
        if (!NSEqualRanges(match, NSMakeRange(NSNotFound, 0))) {
            string = [string stringByReplacingCharactersInRange:match withString:@""];
        }
    }
    string = [string stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceCharacterSet]];
    return [string isEqualToString:@""];
}


#pragma mark - comparison functions


-(BOOL) doesMatchAnswer:(NSString *)answer
{
    if (self.answer == nil) {
        return NO;
    }
    // a key is a required part of a question
    for (NSString* key in [self.answer allKeys]) {
        // the answer contains the key
        if ([self string:answer matchesKey:key]) {
            NSString* extra = answer;
            for (NSString* keyPart in [key componentsSeparatedByString:@", "]) {
                
                NSRange match = [self matchKey:keyPart toString:extra];
            
                if (!NSEqualRanges(match, NSMakeRange(NSNotFound, 0))) {
                    extra = [extra stringByReplacingCharactersInRange:match withString:@""];;
                }
            }
            
            if ([self string:extra matchesExtras:[self.answer objectForKey:key]]) {
                return YES;
            }
        }
    }
    return NO;
}

@end
