//
//  CalculatorAppController.h
//  MyCalculator
//
//  Created by Matthew McAllister on 2013-05-10.
//  Copyright (c) 2013 Matthew McAllister. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CalculatorWindowController.h"

@interface CalculatorAppController : NSObject
{
    CalculatorWindowController *mycwc;
}

- (void) showWindow;

@end
