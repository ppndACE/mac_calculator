//
//  EquationStub.m
//  MyCalculator
//
//  Created by Matthew McAllister on 2013-09-18.
//  Copyright (c) 2013 Matthew McAllister. All rights reserved.
//

#import "EquationStub.h"

@implementation EquationStub

// Overrides inherited parent method
- (void) reset
{
    [super reset];
    [self setBracketLevel:0];
}

- (NSDictionary*)getPrecedenceDict
{
    return precedence_lookup;
}

- (BOOL) getIsRadians
{
    return isRadians;
}

- (BOOL) getIsDegrees
{
    return isDegrees;
}

- (void) pushOntoOutput:(NSNumber*)num
{
    [output push:num];
}

- (NSNumber*) popOutput
{
    return (NSNumber*) [output pop];
}

- (void) pushOntoOperators:(NSString*)op
{
    [operators push:op];
}

- (int) getBracketLevel
{
    return bracket_level;
}

- (void) setBracketLevel:(int)num
{
    bracket_level = num;
}

@end
