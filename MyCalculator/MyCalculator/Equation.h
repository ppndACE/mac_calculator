//
//  Equation.h
//  MyCalculator
//
//  Created by Matthew McAllister on 2013-09-17.
//  Copyright (c) 2013 Matthew McAllister. All rights reserved.
//

#ifndef _EQUATION_H_
#define _EQUATION_H_

#import <Foundation/Foundation.h>
#import "Stack.h"

@interface Equation : NSObject
{
    int bracket_level;
    BOOL isRadians;
    BOOL isDegrees;
    
    Stack *operators; // stack to hold operators
    Stack *output; // stack of numbers
    NSDictionary *precedence_lookup;
    NSMutableArray *equation;
}

- (id) init;
- (void) reset;
- (void) setRadians;
- (void) setDegrees;
- (void) appendStringToEquation:(NSString *)str;
- (NSString *) popLastObject;
- (BOOL) shuntingYard;
- (BOOL) shuntingYardWithEquation:(NSMutableArray *) eq;
- (NSNumber *) checkPrecedence:(NSString*) op;
- (NSNumber *) Evaluate;
- (NSNumber *) EvaluateFunction:(NSString*)func;
- (NSNumber*) EvaluateTrigFunction:(NSString*)func withNumber:(double)d_num;
- (NSNumber *) performShuntingYardComputation;
- (NSNumber *) performShuntingYardComputationWithEquation:(NSMutableArray *) eq;

+ (BOOL) doesOpOpenBracket:(NSString *)op;
+ (BOOL) isOperator:(NSString *)s;
+ (BOOL) isTrigFunction:(NSString*)func;

@end

#endif

