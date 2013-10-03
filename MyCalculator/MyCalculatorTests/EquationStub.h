//
//  EquationStub.h
//  MyCalculator
//
//  Created by Matthew McAllister on 2013-09-18.
//  Copyright (c) 2013 Matthew McAllister. All rights reserved.
//

#import "Equation.h"

@interface EquationStub : Equation

- (void) reset;
- (NSDictionary*)getPrecedenceDict;
- (BOOL) getIsRadians;
- (BOOL) getIsDegrees;
- (void) pushOntoOutput:(NSNumber*)num;
- (NSNumber*) popOutput;
- (void) pushOntoOperators:(NSString*)op;
- (int) getBracketLevel;
- (void) setBracketLevel:(int)num;

@end
