//
//  CalculatorWindowController.m
//  MyCalculator
//
//  Created by Matthew McAllister on 2013-05-10.
//  Copyright (c) 2013 Matthew McAllister. All rights reserved.
//

#import "CalculatorWindowController.h"

@implementation CalculatorWindowController
@synthesize answer_box;

/* Override init */
- (id) init
{
    self = [super initWithWindowNibName:@"CalculatorWindowController"];
    
    return self;
}

- (id) initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

//-----------------------------------------------------
// Initialization after the window loads
//-----------------------------------------------------
- (void) windowDidLoad
{
    [super windowDidLoad];
    
    /* init member vars */
    [self reset];
    
}

//-----------------------------------------------------
// Sets all member vars and display to 0
//-----------------------------------------------------
- (void) reset
{
    [answer_box setStringValue:@"0"];
    current_value = 0;
    first = 0;
    second = 0;
    
    operator_called = NO;
    equals_was_last_called = NO;
    decimal_placed = NO;
    
    operators = eNONE;
}

//-----------------------------------------------------
// Method called when C button is pressed
// -- resets all member vars and sets display back to 0
//-----------------------------------------------------
- (IBAction) On_Clear:(id)sender
{
    [self reset];
}

//-----------------------------------------------------
// Method called when delete button is pressed
// -- on delete key press, delete last character inputted
//-----------------------------------------------------
- (IBAction) On_Delete:(id)sender
{
    NSString *s = [answer_box stringValue];
    
    if ([s length] - 1 != 0) {
        [answer_box setStringValue:[s substringToIndex:[s length] - 1]];
    }
    else {
        [answer_box setStringValue:@"0"];
    }
    
    [self UpdateCurrentValue];
    
}

//-----------------------------------------------------
// Method called when 0 button is pressed
//-----------------------------------------------------
- (IBAction) On_0:(id)sender
{
    [self WriteToAnswerBox:@"0"];
}

//-----------------------------------------------------
// Method called when 1 button is pressed
//-----------------------------------------------------
- (IBAction) On_1:(id)sender
{
    [self WriteToAnswerBox:@"1"];
}

//-----------------------------------------------------
// Method called when 2 button is pressed
//-----------------------------------------------------
- (IBAction) On_2:(id)sender
{
    [self WriteToAnswerBox:@"2"];
}

//-----------------------------------------------------
// Method called when 3 button is pressed
//-----------------------------------------------------
- (IBAction) On_3:(id)sender
{
    [self WriteToAnswerBox:@"3"];
}

//-----------------------------------------------------
// Method called when 4 button is pressed
//-----------------------------------------------------
- (IBAction) On_4:(id)sender
{
    [self WriteToAnswerBox:@"4"];
}

//-----------------------------------------------------
// Method called when 5 button is pressed
//-----------------------------------------------------
- (IBAction) On_5:(id)sender
{
    [self WriteToAnswerBox:@"5"];
}

//-----------------------------------------------------
// Method called when 6 button is pressed
//-----------------------------------------------------
- (IBAction) On_6:(id)sender
{
    [self WriteToAnswerBox:@"6"];
}

//-----------------------------------------------------
// Method called when 7 button is pressed
//-----------------------------------------------------
- (IBAction) On_7:(id)sender
{
    [self WriteToAnswerBox:@"7"];
}

//-----------------------------------------------------
// Method called when 8 button is pressed
//-----------------------------------------------------
- (IBAction) On_8:(id)sender
{
    [self WriteToAnswerBox:@"8"];
}

//-----------------------------------------------------
// Method called when 9 button is pressed
//-----------------------------------------------------
- (IBAction) On_9:(id)sender
{
    [self WriteToAnswerBox:@"9"];
}

//-----------------------------------------------------
// Method called when decimal button is pressed
//-----------------------------------------------------
- (IBAction) On_Decimal:(id)sender
{
    if (!decimal_placed) {
        [self WriteToAnswerBox:@"."];
        decimal_placed = YES;
    }
}

//-----------------------------------------------------
// Method called when addition button is pressed
//-----------------------------------------------------
- (IBAction) On_Plus:(id)sender
{
    first = current_value;
    operator_called = YES;
    operators = PLUS;
}

//-----------------------------------------------------
// Method called when subtraction button is pressed
//-----------------------------------------------------
- (IBAction) On_Minus:(id)sender
{
    first = current_value;
    operator_called = YES;
    operators = MINUS;
}

//-----------------------------------------------------
// Method called when multiplication button is pressed
//-----------------------------------------------------
- (IBAction) On_Mult:(id)sender
{
    first = current_value;
    operator_called = YES;
    operators = MULT;
}

//-----------------------------------------------------
// Method called when division button is pressed
//-----------------------------------------------------
- (IBAction) On_Div:(id)sender
{
    first = current_value;
    operator_called = YES;
    operators = DIV;
}

//-----------------------------------------------------
// Method called when equals button is pressed
//-----------------------------------------------------
- (IBAction) On_Equals:(id)sender
{
    second = current_value;
    operator_called = YES;
    [self WriteToAnswerBox:[self Evaluate]];
    equals_was_last_called = YES;
}

- (NSString *) Evaluate
{
    NSNumber *result = nil;
    
    switch (operators) {
        case PLUS:
            result = [NSNumber numberWithDouble:first + second];
            break;
        case MINUS:
            result = [NSNumber numberWithDouble:first - second];
            break;
        case MULT:
            result = [NSNumber numberWithDouble:first * second];
            break;
        case DIV:
            result = [NSNumber numberWithDouble:first / second];
            break;
        default:
            break;
    }
    
    NSString *s = [result stringValue];
    
    return s;
}

//-----------------------------------------------------
// Logic for appending a value to the answer box
//-----------------------------------------------------
- (NSString *) WriteToAnswerBox:(NSString *)i
{
    
    if (operator_called) {
        [answer_box setStringValue:@"0"];
        current_value = 0;
//        [self On_Clear:self];
        operator_called = NO;
    }
    
    /* if value is 0, replace it, otherwise append */
    if (current_value == 0) {
        [answer_box setStringValue:i];
    }
    else {
        [answer_box setStringValue:[[answer_box stringValue] stringByAppendingString:i]];
    }
    
    [self UpdateCurrentValue];
    
    return [answer_box stringValue];
}

//-----------------------------------------------------
// Updates the variable curent_value according to the
// value stored in the answer box
//-----------------------------------------------------
- (void) UpdateCurrentValue
{
    current_value = [answer_box doubleValue];
}

/********************* Delegate methods *********************/

//-----------------------------------------------------
// Catches window close
//-----------------------------------------------------
- (void) windowWillClose:(NSNotification *)notification
{
    [NSApp stopModal];
}

@end




