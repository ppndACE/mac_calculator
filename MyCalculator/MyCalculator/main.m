//
//  main.m
//  MyCalculator
//
//  Created by Matthew McAllister on 2013-05-06.
//  Copyright (c) 2013 Matthew McAllister. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CalculatorAppController.h"

int main(int argc, char *argv[])
{
    CalculatorAppController *ca = [[CalculatorAppController alloc] init];
    [ca showWindow];
    
    return NSApplicationMain(argc, (const char **)argv);
}
