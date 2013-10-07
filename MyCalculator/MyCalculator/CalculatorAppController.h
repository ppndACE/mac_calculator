//
//  CalculatorAppController.h
//  MyCalculator
//
//  Controls the display of the Window
//
//  Created by Matthew McAllister on 2013-05-10.
//  Copyright (c) 2013 Matthew McAllister. All rights reserved.
//

#ifndef _CALCULATOR_APP_CONTROLLER_H_
#define _CALCULATOR_APP_CONTROLLER_H_

#import <Cocoa/Cocoa.h>
#import "CalculatorWindowController.h"

@interface CalculatorAppController : NSObject
{
    CalculatorWindowController *mycwc;
}

- (void) showWindow;

@end

#endif

