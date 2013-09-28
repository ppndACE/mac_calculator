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
    BOOL was_precedence_init_called;
    BOOL isRadians;
    BOOL isDegrees;
    
    Stack *operators; // stack to hold operators
    Stack *output; // stack of numbers
    NSDictionary *precedence_lookup;
    NSMutableArray *equation;
}

- (id) init;
- (void) reset;
- (void) appendStringToEquation:(NSString *)str;
- (NSString *) popLastObject;
- (BOOL) shuntingYard;
- (BOOL) shuntingYardWithEquation:(NSMutableArray *) eq;
- (void) initPrecendenceDict;
- (NSNumber *) checkPrecedence:(NSString*) op;
- (NSNumber *) Evaluate;
- (NSNumber *) EvaluateFunction:(NSString*)func;
- (NSNumber *) performShuntingYardComputation;
- (NSNumber *) performShuntingYardComputationWithEquation:(NSMutableArray *) eq;
- (void) clear;
- (void) setRadians;
- (void) setDegrees;

+ (BOOL) doesOpOpenBracket:(NSString *)op;

@end

#endif

