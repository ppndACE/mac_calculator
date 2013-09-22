//
//  Equation.m
//  MyCalculator
//
//  Created by Matthew McAllister on 2013-09-17.
//  Copyright (c) 2013 Matthew McAllister. All rights reserved.
//

#import "Equation.h"

#define OPEN_BRACKET_PRECEDENCE 1000

@implementation Equation

BOOL was_precedence_init_called = FALSE;

- (id) init
{
    output = [[Stack alloc] init];
    operators = [[Stack alloc] init];
    equation = [NSMutableArray array];
    //[self initPrecendenceDict];
    return self;
}

- (void) reset
{
    [output removeAllObjects];
    [operators removeAllObjects];
    [equation removeAllObjects];
}

- (void) appendStringToEquation:(NSString *)str
{
    [equation addObject:str];
}

- (NSString *) popLastObject
{
    NSString *last = [equation lastObject];
    [equation removeLastObject];
    return last;
}

- (BOOL) shuntingYard
{
    return [self shuntingYardWithEquation:equation];
}

- (BOOL) shuntingYardWithEquation:(NSMutableArray *)eq
{
    NSString *last_op;
    NSString *item;
    
    // allow NSNumberFormatter to check if the string is a valid floating point number or not
    NSNumberFormatter *nf = [[NSNumberFormatter alloc] init];
    [nf setAllowsFloats:YES];
    
    // iterate in order through equation array of strings to separate numbers from operators
    for (int i = 0; i < [eq count]; i++) {

        item = [eq objectAtIndex:i];
        
        // if string is a number
        if ([nf numberFromString:item]) {
            [output push:item];
        }
        else if ([item isEqualToString:CLOSE_BRACKET]) { // if string is a closing bracket
            
            // pop elements off operators and compute until "(" is encountered
            while (! [(NSString*)[operators peek] isEqualToString:OPEN_BRACKET]) {
                
                last_op = (NSString*)[operators peek];
                
                // case when there are unmatching ")" brackets. should return error
                if (last_op == nil) {
                    return FALSE;
                }
                
                [self Evaluate];
            }
            
            // pop off @"(", because expression inside brackets should have been computed by now
            [operators pop];
        }
        else { // if string is another operator
            
            if (!was_precedence_init_called) {
                [self initPrecendenceDict];
            }
            
            NSNumber *current = [self checkPrecedence:item];
            NSNumber *top_stack;
            
            // first elem here in while loop is the top item of the stack
            while (TRUE) {
                top_stack = [self checkPrecedence:(NSString*)[operators peek]];
                
                // if the precedence is not equal to OPEN_BRACKET_PRECEDENCE and is greater than current
                if (! ([top_stack intValue] == OPEN_BRACKET_PRECEDENCE) &&
                       [top_stack isGreaterThanOrEqualTo:current]
                ) {
                    [self Evaluate];
                }
                else {
                    break;
                }
            }
            
            // after computing, push item onto operators stack
            [operators push:item];
        }
    }
    
    // if successful, remove objects from equation because operators and output will be in appropriate locations
    [equation removeAllObjects];
    
    return TRUE;
}

- (void) initPrecendenceDict
{
    NSArray *valid_operators = [NSArray arrayWithObjects:
                                    PLUS,
                                    MINUS,
                                    DIV,
                                    MULT,
                                    POW,
                                    OPEN_BRACKET,
                                    ROOT,
                                nil];
    
    NSArray *precedences = [NSArray arrayWithObjects:
                                    [NSNumber numberWithInt:1],
                                    [NSNumber numberWithInt:1],
                                    [NSNumber numberWithInt:2],
                                    [NSNumber numberWithInt:2],
                                    [NSNumber numberWithInt:3],
                                    [NSNumber numberWithInt:OPEN_BRACKET_PRECEDENCE],
                                    [NSNumber numberWithInt:OPEN_BRACKET_PRECEDENCE],
                                nil];
    
    precedence_lookup = [NSDictionary dictionaryWithObjects:precedences forKeys:valid_operators];
    
    was_precedence_init_called = TRUE;
}

- (NSNumber*) checkPrecedence:(NSString*)op
{
    return [precedence_lookup objectForKey:op];
}

//-----------------------------------------------------
// Evaluates one expression (one operator)
//-----------------------------------------------------
- (NSNumber*) Evaluate
{
    NSNumber *result = nil;
    
    NSString *op = (NSString*) [operators pop];
    NSNumber *second = (NSNumber*) [output pop];
    NSNumber *first = (NSNumber*) [output pop];
    
    // need to also account for case where a bracket may start the equation, i think
    if (first == nil || second == nil) {
        return FALSE; // unmatched numbers & operators
    } // this case probably shouldn't happen though
    
//TODO: check here for null numbers -- IMPORTANT
    
    // determines which operation to run according to operator popped
    // unfortunately can't do a switch on NSStrings :(
    if ([op isEqualToString:PLUS]) {
        result = [NSNumber numberWithDouble:([first doubleValue] + [second doubleValue])];
    }
    else if ([op isEqualToString:MINUS]) {
        result = [NSNumber numberWithDouble:([first doubleValue] - [second doubleValue])];
    }
    else if ([op isEqualToString:MULT]) {
        result = [NSNumber numberWithDouble:([first doubleValue] * [second doubleValue])];
    }
    else if ([op isEqualToString:DIV]) {
        
        if ([second doubleValue] == 0) {
            result = nil;
        }
        else {
            result = [NSNumber numberWithDouble:([first doubleValue] / [second doubleValue])];
        }
    }
    else if ([op isEqualToString:POW]) {
        result = [NSNumber numberWithDouble:pow([first doubleValue], [second doubleValue])];
    }
    else { // this case should never happen unless the operator is an unmatched open bracket @"("
        result = nil;
    }
    
    // push the result of the evaluated expression back onto the output stack
    if (result) {
        [output push:result];
    }
    
    /* return the evaluated operation as an NSNumber */
    return result;
}

- (NSNumber*) performShuntingYardComputation
{
    return [self performShuntingYardComputationWithEquation:equation];
}

- (NSNumber*) performShuntingYardComputationWithEquation:(NSMutableArray *)eq
{
    NSNumber *n;
    
    if ([self shuntingYardWithEquation:eq]) {
        
        while ([output count] > 1) {
            n = [self Evaluate];
            
            // should happen if unmatched opening bracket
            if (!n) {
                return nil;
            }
        }
        
        // return last element left over
        return (NSNumber*)[output pop];
    }

    // else there was an issue, and shuntingYardWithEquation method returned false
    return nil;
    
}

// removes all objects and resets internal vars
- (void) clear
{
    [output removeAllObjects];
    [operators removeAllObjects];
}

// will probably need to add a method that compares operator to a slew of function operators
- (BOOL) doesOpOpenBracket:(NSString *)op
{
    if ([op isEqualToString:OPEN_BRACKET] ||
        [op isEqualToString:ROOT]
        ) {
                return YES;
    }
    
    return NO;
}

@end




