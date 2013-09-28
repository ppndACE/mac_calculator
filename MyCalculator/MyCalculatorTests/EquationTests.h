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
    NSMutableArray *eq_mismatch_brackets;
    
    NSNumber *res_no_brackets;
    NSNumber *res_brackets;
    NSNumber *res_mismatch_brackets;
}

@end
