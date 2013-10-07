//
//  StackTests.m
//  MyCalculator
//
//  Created by Matthew McAllister on 2013-09-18.
//  Copyright (c) 2013 Matthew McAllister. All rights reserved.
//

#import "StackTests.h"

@implementation StackTests

- (void) setUp
{
    s = [[Stack alloc] init];
}

// tests stack push method with an NSString object
- (void) testPushString
{
    STAssertTrue([s isEmpty], @"s is not empty");
    
    NSString *str = @"hello";
    [s push:str];
    
    STAssertFalse([s isEmpty], @"s is empty");
    STAssertEquals([s peek], str, @"compare peek elem and str");
}

// tests stack pop method with an NSString object
- (void) testPopString
{
    STAssertTrue([s isEmpty], @"s is not empty");
    
    // push string here
    NSString *str = @"hello";
    [s push:str];
    
    STAssertFalse([s isEmpty], @"s is empty");
    
    // pop string here
    NSString *check = (NSString*)[s pop];
    
    STAssertEqualObjects(str, check, @"different strings. error");
    STAssertTrue([s isEmpty], @"s is not empty");
}


@end
