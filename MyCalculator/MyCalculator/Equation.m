
//  Equation.m
//  MyCalculator
//
//  Created by Matthew McAllister on 2013-09-17.
//  Copyright (c) 2013 Matthew McAllister. All rights reserved.
//

#import "Equation.h"

#define OPEN_BRACKET_PRECEDENCE 1000

@implementation Equation

//-----------------------------------------------------
// Initializes the Equation object
//-----------------------------------------------------
- (id) init
{
    bracket_level = 0;
    isRadians = YES;
    isDegrees = NO;
    
    output = [[Stack alloc] init];
    operators = [[Stack alloc] init];
    equation = [NSMutableArray array];
    [self initPrecendenceDict];
    return self;
}

//-----------------------------------------------------
// Deletes all objects in arrays and stacks
//-----------------------------------------------------
- (void) reset
{
    bracket_level = 0;
    
    [output removeAllObjects];
    [operators removeAllObjects];
    [equation removeAllObjects];
}

//-----------------------------------------------------
// Sets isRadians BOOL and unsets isDegrees
//-----------------------------------------------------
- (void) setRadians
{
    isRadians = YES;
    isDegrees = NO;
}

//-----------------------------------------------------
// Sets isDegrees BOOL and unsets isRadians
//-----------------------------------------------------
- (void) setDegrees
{
    isRadians = NO;
    isDegrees = YES;
}

//-----------------------------------------------------
// Appends string to equation as an extra object
//-----------------------------------------------------
- (void) appendStringToEquation:(NSString *)str
{
    [equation addObject:str];
}

//-----------------------------------------------------
// Pops off the last object from equation array
//-----------------------------------------------------
- (NSString *) popLastObject
{
    NSString *last = [equation lastObject];
    [equation removeLastObject];
    return last;
}

//-----------------------------------------------------
// Inserts MULT strings into equation array if there
// is a number followed by a bracket / function
// (eg. 1 + 2 ( 3 + 4 )
//-----------------------------------------------------
- (void) insertMultsIfNeeded:(NSMutableArray*)eq
{
    int i;
    NSString *obj;
    
    // loop over contents of equation and search for @"("
    // start from object 1 because
    for (i = 1; i < [eq count]; i++) {
        
        obj = [eq objectAtIndex:i];
        
        // if obj is a function operator, and the previous object in the
        // equation array is not an operator, insert MULT in between these
        
        if ([[self class] doesOpOpenBracket:obj] &&
            ![[self class] isOperator:[eq objectAtIndex:(i - 1)]]
            ) {
            [eq insertObject:MULT atIndex:i];
        }
    }
}

- (void) appendClosingBracketsIfNeeded:(NSMutableArray*)eq
{
    
}

//-----------------------------------------------------
// Performs the shunting-yard algorithm with the
// internal equation array, which creates output and
// operator stacks and evaluates operations in between
//-----------------------------------------------------
- (BOOL) shuntingYard
{
    return [self shuntingYardWithEquation:equation];
}

//-----------------------------------------------------
// Performs the shunting-yard algorithm with an
// equation array eq, which creates output and
// operator stacks and evaluates operations in between
//-----------------------------------------------------
- (BOOL) shuntingYardWithEquation:(NSMutableArray *)eq
{
    // check for empty eq array
    if ([eq count] == 0) {
        return FALSE;
    }
    
    NSString *last_op;
    NSString *item;
    
    [self insertMultsIfNeeded:eq];
    [self appendClosingBracketsIfNeeded:eq];
    
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
            
            bracket_level--;
            
            // pop elements off operators and compute until "(" is encountered
            while (! [[self class] doesOpOpenBracket:(NSString*) [operators peek]]) {
                last_op = (NSString*)[operators peek];
                
                // case when there are unmatching ")" brackets. should return error
                if (last_op == nil) {
                    return FALSE;
                }
                
                [self Evaluate];
            }
            
            // pop off @"(", because expression inside brackets should have been computed by now
            // update: since all functions are considered as open brackets, check to determine whether we need
            // to compute anything extra, or if the operator is a simple open bracket
            NSString *temp_op = (NSString*)[operators pop];
            if (![temp_op isEqualToString:OPEN_BRACKET]) {
                [self EvaluateFunction:temp_op];
            }
            // else, the operator is a simple close bracket, and no further computation is necessary
        }
        else { // if string is another operator
            NSNumber *current = [self checkPrecedence:item];
            
            // if the operator is a bracket
            if ([current intValue] == OPEN_BRACKET_PRECEDENCE) {
                bracket_level++;
            }
            
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
    
    if (bracket_level == 0) {
        return TRUE;
    }
    else return FALSE;
}

//-----------------------------------------------------
// Initializes precedence dictionary
//-----------------------------------------------------
- (void) initPrecendenceDict
{
    // array holding all valid operators offered by calculator
    NSArray *valid_operators = [NSArray arrayWithObjects:
                                    PLUS,
                                    MINUS,
                                    DIV,
                                    MULT,
                                    POW,
                                    OPEN_BRACKET,
                                    ROOT,
                                    SIN,
                                    COS,
                                    TAN,
                                    LOG,
                                    LN,
                                    E_POW,
                                nil];
    
    // array holding all precedences corresponding to available operators above
    NSArray *precedences = [NSArray arrayWithObjects:
                                    [NSNumber numberWithInt:1],
                                    [NSNumber numberWithInt:1],
                                    [NSNumber numberWithInt:2],
                                    [NSNumber numberWithInt:2],
                                    [NSNumber numberWithInt:3],
                                    [NSNumber numberWithInt:OPEN_BRACKET_PRECEDENCE],
                                    [NSNumber numberWithInt:OPEN_BRACKET_PRECEDENCE],
                                    [NSNumber numberWithInt:OPEN_BRACKET_PRECEDENCE],
                                    [NSNumber numberWithInt:OPEN_BRACKET_PRECEDENCE],
                                    [NSNumber numberWithInt:OPEN_BRACKET_PRECEDENCE],
                                    [NSNumber numberWithInt:OPEN_BRACKET_PRECEDENCE],
                                    [NSNumber numberWithInt:OPEN_BRACKET_PRECEDENCE],
                                    [NSNumber numberWithInt:OPEN_BRACKET_PRECEDENCE],
                                nil];
    
    // create precedence_lookup dictionary
    precedence_lookup = [NSDictionary dictionaryWithObjects:precedences forKeys:valid_operators];
}

//-----------------------------------------------------
// Checks precedence of operator op
//-----------------------------------------------------
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
    else { // this case should never happen unless the operator is an unmatched open bracket @"(" or function
        result = nil;
    }
    
    // push the result of the evaluated expression back onto the output stack
    if (result) {
        [output push:result];
    }
    
    /* return the evaluated operation as an NSNumber */
    return result;
}

//-----------------------------------------------------
// Evaluates one function func, with operator
//-----------------------------------------------------
- (NSNumber*) EvaluateFunction:(NSString*)func
{
    NSNumber *result = nil;
    NSNumber *num = (NSNumber*)[output pop];
    
    double d_num = [num doubleValue];
    
    // check for NULL number
    if (num == nil) {
        return nil;
    }
    
    // check for degrees and radians being set to same value
    if ((isDegrees && isRadians) || (!isDegrees && !isRadians)) {
        return nil;
    }

    // switch according to value of string
    if ([[self class] isTrigFunction:func]) {
        result = [self EvaluateTrigFunction:func withNumber:d_num];
    }
    else if ([func isEqualToString:ROOT]) {
        result = [NSNumber numberWithDouble:sqrt(d_num)];
    }
    else if ([func isEqualToString:LOG]) {
        
        // check for invalid number (would normally return -inf)
        if (d_num == 0) {
            result = nil;
            [self reset];
        } else {
            result = [NSNumber numberWithDouble:log10(d_num)];
        }
    }
    else if ([func isEqualToString:LN]) {
        
        // check for invalid number (would normally return -inf)
        if (d_num == 0) {
            result = nil;
            [self reset];
        } else {
            result = [NSNumber numberWithDouble:log(d_num)];
        }
    }
    else if ([func isEqualToString:E_POW]) {
        result = [NSNumber numberWithDouble:pow(M_E, d_num)];
    }
    else { //case should never happen
        result = nil;
    }
    
    // push result back onto output stack
    if (result) {
        [output push:result];
    }
    
    return result;
}

//-----------------------------------------------------
// Evaluates one trig function func, with number d_num
// Invalid checks is performed in EvaluateFunction
//-----------------------------------------------------
- (NSNumber*) EvaluateTrigFunction:(NSString*)func withNumber:(double)d_num
{
    NSNumber *result;
    
    if (isDegrees) {
        d_num = [self convertDegreesToRadians:d_num];
    }
    
    if ([func isEqualToString:SIN]) {
        result = [NSNumber numberWithDouble:sin(d_num)];
    }
    else if ([func isEqualToString:COS]) {
        result = [NSNumber numberWithDouble:cos(d_num)];
    }
    else if ([func isEqualToString:TAN]) {
        result = [NSNumber numberWithDouble:tan(d_num)];
    }
    else {
        result = nil;
    }
    
    return result;
}

//-----------------------------------------------------
// Converts num from degrees to radians, in order to
// correctly compute trig functions
//-----------------------------------------------------
- (double) convertDegreesToRadians:(double)num
{
    return num * M_PI / 180;
}

//-----------------------------------------------------
// Performs the shunting-yard algorithm and computes
// all remaining operations from internal equation array
//-----------------------------------------------------
- (NSNumber*) performShuntingYardComputation
{
    return [self performShuntingYardComputationWithEquation:equation];
}

//-----------------------------------------------------
// Performs the shunting-yard algorithm and computes
// all remaining operations from equation array eq
//-----------------------------------------------------
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
        
        // check that last element is not an NSString anymore, and that it has
        // successfully been changed to an NSNumber. If not, change it here.
        
        if ([[output peek] isKindOfClass:[NSString class]]) {
            NSNumberFormatter *nf = [[NSNumberFormatter alloc] init];
            [nf setAllowsFloats:YES];
            n = [nf numberFromString:(NSString*)[output pop]];
        }
        else {
        
            // return last element left over
            n = (NSNumber*)[output pop];
        }
        
        return n;
    }

    // else there was an issue, and shuntingYardWithEquation method returned false
    return nil;
}

//-----------------------------------------------------
// Compares operator op to function operators to
// determine whether it contains an open bracket @"("
//-----------------------------------------------------
+ (BOOL) doesOpOpenBracket:(NSString *)op
{
    // compare op to functions which open a bracket (eg. @"sin("...))
    if ([op isEqualToString:OPEN_BRACKET]   ||
        [op isEqualToString:ROOT]           ||
        [[self class] isTrigFunction:op]    ||
        [op isEqualToString:LOG]            ||
        [op isEqualToString:LN]             ||
        [op isEqualToString:E_POW]
        ) {
                return YES;
    }
    
    return NO;
}

//-----------------------------------------------------
// Checks whether the function operator is a trig function
//-----------------------------------------------------
+ (BOOL) isTrigFunction:(NSString*)func
{
    if ([func isEqualToString:SIN] ||
        [func isEqualToString:COS] ||
        [func isEqualToString:TAN]
        ) {
        
        return YES;
    }
    
    return NO;
}

//-----------------------------------------------------
// Returns YES if input string is an operator
//-----------------------------------------------------
+ (BOOL) isOperator:(NSString *)s
{
    if ([[self class] doesOpOpenBracket:s]  ||
        [s isEqualToString:PLUS]           ||
        [s isEqualToString:MINUS]          ||
        [s isEqualToString:MULT]           ||
        [s isEqualToString:DIV]            ||
        [s isEqualToString:POW]
        ) {
        return YES;
    }
    
    return NO;
}

@end




