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
    Stack *operators; // stack to hold operators
    Stack *output; // stack of numbers
    NSDictionary *precedence_lookup;
}

- (id) init;
- (BOOL) shuntingYardWithEquation:(NSMutableArray *) equation;
- (void) initPrecendenceDict;
- (NSNumber *) checkPrecedence:(NSString*) op;
- (NSNumber *) Evaluate;
- (NSNumber *) performShuntingYardComputationWithEquation:(NSMutableArray *) equation;
- (void) clear;

@end

#endif

