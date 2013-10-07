//
//  EquationTests.h
//  MyCalculator
//
//  Created by Matthew McAllister on 2013-09-18.
//  Copyright (c) 2013 Matthew McAllister. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "EquationStub.h"

@interface EquationTests : SenTestCase
{
    EquationStub *e;
    
    double lambda;
    
    NSMutableArray *eq_no_brackets;
    NSMutableArray *eq_brackets;
    NSMutableArray *eq_mismatch_brackets_1;
    NSMutableArray *eq_mismatch_brackets_2;
    NSMutableArray *eq_start_function;
    NSMutableArray *eq_times_function;
    NSMutableArray *eq_double_op;
    
    NSNumber *res_no_brackets;
    NSNumber *res_brackets;
    NSNumber *res_mismatch_brackets_1;
    NSNumber *res_mismatch_brackets_2;
    NSNumber *res_start_function;
    NSNumber *res_times_function;
    NSNumber *res_double_op;
}

@end
