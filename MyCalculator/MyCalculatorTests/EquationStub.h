//
//  EquationStub.h
//  MyCalculator
//
//  Created by Matthew McAllister on 2013-09-18.
//  Copyright (c) 2013 Matthew McAllister. All rights reserved.
//

#import "Equation.h"

@interface EquationStub : Equation

- (NSDictionary*)getPrecedenceDict;
- (void) pushOntoOutput:(NSNumber*)num;
- (NSNumber*) popOutput;
- (void) pushOntoOperators:(NSString*)op;

@end
