//
//  EquationTests.m
//  MyCalculator
//
//  Created by Matthew McAllister on 2013-09-18.
//  Copyright (c) 2013 Matthew McAllister. All rights reserved.
//

#import "EquationTests.h"

@implementation EquationTests

// setup performed before each method in this class
- (void) setUp
{
    [super setUp];
    e = [[EquationStub alloc] init];
    
    eq_no_brackets = [NSMutableArray arrayWithObjects:@"1", @"+", @"2", @"*", @"8", nil];
    eq_brackets = [NSMutableArray arrayWithObjects:@"3", @"*", @"(", @"2", @"+", @"4", @")", nil];
    eq_mismatch_brackets = [NSMutableArray arrayWithObjects:@"3", @"*", @"2", @"+", @"4", @")", nil];
    
    res_no_brackets = [NSNumber numberWithDouble:(1 + 2 * 8)];
    res_brackets = [NSNumber numberWithDouble:(3 * ( 2 + 4 ))];
    res_mismatch_brackets = nil;
}

// tests initPrecedenceDict method
- (void) testInitPrecedenceDict
{
    STAssertNil([e getPrecedenceDict], @"precedence dictionary is not nil on startup");
    [e initPrecendenceDict];
    
    NSDictionary *d = [e getPrecedenceDict];

    STAssertNotNil(d, @"precedence dictionary was not initted properly");
}

// tests Evaluate method with adding ints
- (void) testEvaluateAdd
{
    int i1 = 3;
    int i2 = 5;
    int i3 = i1 + i2;
    
    [e pushOntoOperators:@"+"];
    [e pushOntoOutput:[NSNumber numberWithInt:i1]];
    [e pushOntoOutput:[NSNumber numberWithInt:i2]];
    
    [e Evaluate];
    
    STAssertEquals([[e popOutput] intValue], [[NSNumber numberWithInt:i3] intValue], @"Evaluate-->add fail");
}

// tests Evaluate method with subtracting ints
- (void) testEvaluateSub
{
    int i1 = 3;
    int i2 = 5;
    int i3 = i1 - i2;
    
    [e pushOntoOperators:@"-"];
    [e pushOntoOutput:[NSNumber numberWithInt:i1]];
    [e pushOntoOutput:[NSNumber numberWithInt:i2]];
    
    [e Evaluate];
    
    STAssertEquals([[e popOutput] intValue], [[NSNumber numberWithInt:i3] intValue], @"Evaluate-->sub fail");
}

// tests Evaluate method with multiplying ints
- (void) testEvaluateMult
{
    int i1 = 3;
    int i2 = 5;
    int i3 = i1 * i2;
    
    [e pushOntoOperators:@"*"];
    [e pushOntoOutput:[NSNumber numberWithInt:i1]];
    [e pushOntoOutput:[NSNumber numberWithInt:i2]];
    
    [e Evaluate];
    
    STAssertEquals([[e popOutput] intValue], [[NSNumber numberWithInt:i3] intValue], @"Evaluate-->mult fail");
}

// tests Evaluate method with dividing ints to a double
- (void) testEvaluateDiv
{
    int i1 = 1;
    int i2 = 3;
    double i3 = (double) i1 / i2;
    
    [e pushOntoOperators:@"/"];
    [e pushOntoOutput:[NSNumber numberWithInt:i1]];
    [e pushOntoOutput:[NSNumber numberWithInt:i2]];
    
    [e Evaluate];
    
    STAssertEquals([[e popOutput] doubleValue], [[NSNumber numberWithDouble:i3] doubleValue], @"Evaluate-->div fail");
}

// tests Evaluate method with multiplying and adding ints
- (void) testEvaluateAddMult
{
    int i1 = 1;
    int i2 = 2;
    int i3 = 8;
    int i4 = i1 + i2 * i3;
    
    [e pushOntoOutput:[NSNumber numberWithInt:i1]];
    [e pushOntoOperators:@"+"];
    [e pushOntoOutput:[NSNumber numberWithInt:i2]];
    [e pushOntoOperators:@"*"];
    [e pushOntoOutput:[NSNumber numberWithInt:i3]];
    
    [e Evaluate];
    [e Evaluate];
    
    STAssertEquals([[e popOutput] intValue], [[NSNumber numberWithInt:i4] intValue], @"Evaluate-->addmult fail");
}

// test shuntingYardWithEquation method
- (void) testShuntingYard
{
    BOOL b = [e shuntingYardWithEquation:eq_no_brackets];
    STAssertTrue(b, @"shunting yard error");
    
    b = [e shuntingYardWithEquation:eq_brackets];
    STAssertTrue(b, @"shunting yard error");
    
    // this case should purposely be false because the eq has mismatched @")"
    b = [e shuntingYardWithEquation:eq_mismatch_brackets];
    STAssertFalse(b, @"unmatched bracket shunting yard no fail");
}

// tests performShuntingYardComputationWithEquation method
- (void) testPerformShuntingYard
{
    NSNumber *result = [e performShuntingYardComputationWithEquation:eq_no_brackets];
    STAssertEqualObjects(result, res_no_brackets, @"no brackets results don't match");
    
    result = [e performShuntingYardComputationWithEquation:eq_brackets];
    STAssertEqualObjects(result, res_brackets, @"brackets results don't match");
    
    result = [e performShuntingYardComputationWithEquation:eq_mismatch_brackets];
    STAssertEqualObjects(result, res_mismatch_brackets, @"mismatched not nil");
}


@end
