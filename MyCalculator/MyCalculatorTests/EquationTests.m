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
    
    lambda = 0.0000001;
    
    eq_no_brackets = [NSMutableArray arrayWithObjects:@"1", @"+", @"2", @"*", @"8", nil];
    eq_brackets = [NSMutableArray arrayWithObjects:@"1", @"+", @"3", @"*", @"(", @"2", @"+", @"4", @")", @"^", @"2", nil];
    eq_mismatch_brackets = [NSMutableArray arrayWithObjects:@"3", @"*", @"2", @"+", @"4", @")", nil];
    eq_start_function = [NSMutableArray arrayWithObjects:@"cos(", @"0", @")", nil];
    eq_times_function = [NSMutableArray arrayWithObjects:@"5", @"+", @"4", @"cos(", @"0", @")", nil];
    eq_double_op = [NSMutableArray arrayWithObjects:@"1", @"+", @"+", @"3", nil];
    
    res_no_brackets = [NSNumber numberWithDouble:(1 + 2 * 8)];
    res_brackets = [NSNumber numberWithDouble:(1 + 3 * pow(( 2 + 4 ), 2))];
    res_mismatch_brackets = nil;
    res_start_function = [NSNumber numberWithDouble:(cos(0))];
    res_times_function = [NSNumber numberWithDouble:(5 + 4 * cos(0))];
    res_double_op = nil;
}

- (void) tearDown
{
    [super tearDown];
    [e reset];
}

// tests setDegrees and setRadians methods
- (void) testSetDegreesAndRadians
{
    // initially
    BOOL b = [e getIsRadians];
    BOOL c = [e getIsDegrees];
    
    STAssertTrue(b, @"initially, radians set improperly");
    STAssertFalse(c, @"initially, degrees set improperly");
    
    [e setDegrees];
    
    b = [e getIsRadians];
    c = [e getIsDegrees];
    
    STAssertFalse(b, @"after setDegrees, radians set improperly");
    STAssertTrue(c, @"after setDegrees, degrees set improperly");
    
    [e setRadians];
    
    b = [e getIsRadians];
    c = [e getIsDegrees];
    
    STAssertTrue(b, @"after setRadians, radians set improperly");
    STAssertFalse(c, @"after setRadians, degrees set improperly");
}

// tests initPrecedenceDict method
- (void) testInit
{
    STAssertNotNil([e getPrecedenceDict], @"precedence dictionary is nil on startup");
    STAssertEquals(0, [e getBracketLevel], @"improper bracket level");
    STAssertTrue([e getIsRadians], @"radians not set");
    STAssertFalse([e getIsDegrees], @"degrees set");
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
    
    STAssertEquals([[e popOutput] intValue], i4, @"Evaluate-->addmult fail");
}

// tests shuntingYard algorithm with sin
- (void) testEvaluateFuncSin
{
    double pi_2 = M_PI / 2;
    double ans = sin(pi_2);
    
    STAssertTrue([e getIsRadians], @"not radians");
    
    [e pushOntoOutput:[NSNumber numberWithDouble:pi_2]];
    NSNumber *n_ret = [e EvaluateFunction:SIN];
    
    STAssertEqualsWithAccuracy(ans, [n_ret doubleValue], lambda, @"shunting yard sin error");
    
    [e setDegrees];
    
    STAssertTrue([e getIsDegrees], @"not degrees");
    
    [e pushOntoOutput:[NSNumber numberWithDouble:180]];
    NSNumber *n_ret2 = [e EvaluateFunction:SIN];
    
    STAssertEqualsWithAccuracy(0.0, [n_ret2 doubleValue], lambda, @"shunting yard sin error");
    
    [e pushOntoOutput:[NSNumber numberWithDouble:-90]];
    NSNumber *n_ret3 = [e EvaluateFunction:SIN];
    
    STAssertEqualsWithAccuracy(-1.0, [n_ret3 doubleValue], lambda, @"shunting yard sin error");
}

// test shuntingYardWithEquation method
- (void) testShuntingYard
{
    BOOL b = [e shuntingYardWithEquation:eq_no_brackets];
    STAssertTrue(b, @"shunting yard error");
    [e reset];
    
    b = [e shuntingYardWithEquation:eq_brackets];
    STAssertTrue(b, @"shunting yard error");
    [e reset];
    
    // this case should purposely be false because the eq has mismatched @")"
    b = [e shuntingYardWithEquation:eq_mismatch_brackets];
    STAssertFalse(b, @"unmatched bracket shunting yard no fail");
    [e reset];
    
    b = [e shuntingYardWithEquation:eq_start_function];
    STAssertTrue(b, @"eq starting with function shunting yard error");
    [e reset];
}

// tests performShuntingYardComputationWithEquation method
- (void) testPerformShuntingYard
{
    NSNumber *result;
    
    result = [e performShuntingYardComputationWithEquation:eq_no_brackets];
    STAssertEqualObjects(result, res_no_brackets, @"no brackets results don't match");
    [e reset];
    
    result = [e performShuntingYardComputationWithEquation:eq_brackets];
    STAssertEqualObjects(result, res_brackets, @"brackets results don't match");
    [e reset];
    
    result = [e performShuntingYardComputationWithEquation:eq_mismatch_brackets];
    STAssertEqualObjects(result, res_mismatch_brackets, @"mismatched not nil");
    [e reset];
    
    result = [e performShuntingYardComputationWithEquation:eq_start_function];
    STAssertEqualObjects(result, res_start_function, @"eq starting with func, broken");
    [e reset];
    
    result = [e performShuntingYardComputationWithEquation:eq_times_function];
    STAssertEqualObjects(result, res_times_function, @"eq times func broken");
    [e reset];
    
//    result = [e performShuntingYardComputationWithEquation:eq_double_op];
//    STAssertEqualObjects(result, res_double_op, @"eq double op broken");
}


@end
