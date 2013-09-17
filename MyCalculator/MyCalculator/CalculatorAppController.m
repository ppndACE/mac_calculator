//
//  CalculatorAppController.m
//  MyCalculator
//
//  Created by Matthew McAllister on 2013-05-10.
//  Copyright (c) 2013 Matthew McAllister. All rights reserved.
//

#import "CalculatorAppController.h"

@implementation CalculatorAppController

- (void) showWindow
{
    /* Get window controller */
    if (!mycwc) {
        mycwc = [[CalculatorWindowController alloc] init];
    }
    
    [mycwc showWindow:nil];
}

@end
