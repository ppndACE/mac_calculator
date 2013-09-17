//
//  AppDelegate.m
//  MyCalculator
//
//  Created by Matthew McAllister on 2013-05-06.
//  Copyright (c) 2013 Matthew McAllister. All rights reserved.
//

#import "AppDelegate.h"
#import "CalculatorAppController.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
}

- (NSApplicationTerminateReply)applicationShouldTerminate:(NSApplication *)sender
{
    return NSTerminateNow;
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender
{
    return YES;
}

@end

