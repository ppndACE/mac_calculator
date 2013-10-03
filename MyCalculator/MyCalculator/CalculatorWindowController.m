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
@synthesize equation;
@synthesize matrix_degrad;

//-----------------------------------------------------
// Override init
//-----------------------------------------------------
- (id) init
{
    e = [[Equation alloc] init];
    current_value = [[NSMutableString alloc] initWithString:@""];
    return [super initWithWindowNibName:@"CalculatorWindowController"];
}

//-----------------------------------------------------
// Initialization after the window loads
//-----------------------------------------------------
- (void) windowDidLoad
{
    [super windowDidLoad];
    
    /* init member vars */
    [self resetAll];
}

//-----------------------------------------------------
// Sets all member vars and display to 0
//-----------------------------------------------------
- (void) resetAll
{
    [current_value setString:@""];
    [answer_box setStringValue:@"0"];
    [equation setStringValue:@""];
    
    operator_called = NO;
    equals_was_last_called = NO;
    decimal_placed = NO;
    was_last_close_bracket = NO;
    
    [e reset];
}

//-----------------------------------------------------
// Method called when C button is pressed
// -- resets all member vars and sets display back to 0
//-----------------------------------------------------
- (IBAction) On_Clear:(id)sender
{
    [self resetAll];
}

//-----------------------------------------------------
// Method called when delete button is pressed
// -- on delete key press, delete last number inputted
//-----------------------------------------------------
- (IBAction) On_Delete:(id)sender
{
    // the way this calculator is set up, the user cannot delete an operator,
    // or a number if equals has just been pressed
    if (equals_was_last_called || operator_called) {
        return;
    }
    
    NSUInteger len = [current_value length];
    if (len == 0) {
        return;
    }
    
    // check that length is valid for removing 1 element
    if (len > 0) {
        [equation setStringValue:[[equation stringValue] substringToIndex:[[equation stringValue] length] - 1]];
    }
    
    // if current_value's last remaining char is deleted, make it equal to 0
    // else if it has more than 1 char remaining, simply subtract one
    if ([current_value length] == 1) {
        [self UpdateCurrentValueWithString:[current_value substringToIndex:[current_value length] - 1]];
        [answer_box setStringValue:ZERO];
    }
    else if ([current_value length] > 0) {
        [self UpdateCurrentValueWithString:[current_value substringToIndex:[current_value length] - 1]];
    }
    // else do nothing
}

//-----------------------------------------------------
// Method called when value in matrix is switched
// if Tag == 0, degrees
// if Tag == 1, radians
//-----------------------------------------------------
- (IBAction)On_Matrix:(id)sender
{
    if ([matrix_degrad selectedTag] == 0) {
        [e setDegrees];
    } else { // selectedTag == 1
        [e setRadians];
    }
}

//-----------------------------------------------------
// Method called when 0 button is pressed
//-----------------------------------------------------
- (IBAction) On_0:(id)sender
{
    if (! [current_value isEqualToString:ZERO]) {
        [self On_RegNum:ZERO];
    }
}

//-----------------------------------------------------
// Method called when 1 button is pressed
//-----------------------------------------------------
- (IBAction) On_1:(id)sender
{
    [self On_RegNum:ONE];
}

//-----------------------------------------------------
// Method called when 2 button is pressed
//-----------------------------------------------------
- (IBAction) On_2:(id)sender
{
    [self On_RegNum:TWO];
}

//-----------------------------------------------------
// Method called when 3 button is pressed
//-----------------------------------------------------
- (IBAction) On_3:(id)sender
{
    [self On_RegNum:THREE];
}

//-----------------------------------------------------
// Method called when 4 button is pressed
//-----------------------------------------------------
- (IBAction) On_4:(id)sender
{
    [self On_RegNum:FOUR];
}

//-----------------------------------------------------
// Method called when 5 button is pressed
//-----------------------------------------------------
- (IBAction) On_5:(id)sender
{
    [self On_RegNum:FIVE];
}

//-----------------------------------------------------
// Method called when 6 button is pressed
//-----------------------------------------------------
- (IBAction) On_6:(id)sender
{
    [self On_RegNum:SIX];
}

//-----------------------------------------------------
// Method called when 7 button is pressed
//-----------------------------------------------------
- (IBAction) On_7:(id)sender
{
    [self On_RegNum:SEVEN];
}

//-----------------------------------------------------
// Method called when 8 button is pressed
//-----------------------------------------------------
- (IBAction) On_8:(id)sender
{
    [self On_RegNum:EIGHT];
}

//-----------------------------------------------------
// Method called when 9 button is pressed
//-----------------------------------------------------
- (IBAction) On_9:(id)sender
{
    [self On_RegNum:NINE];
}

//-----------------------------------------------------
// Method called when decimal button is pressed
//-----------------------------------------------------
- (IBAction) On_Decimal:(id)sender
{
    if (!decimal_placed) {
        
        // according to current_value, run either @"0." or just @"."
        if ([current_value isEqualToString:@""]) {
            [self On_RegNum:@"0."];
        } else {
            [self On_RegNum:DEC];
        }
        
        decimal_placed = YES;
    }
}

//-----------------------------------------------------
// Method called when open bracket button is pressed
//-----------------------------------------------------
- (IBAction)On_Open_Bracket:(id)sender
{
    [self On_RegOp:OPEN_BRACKET];
}

//-----------------------------------------------------
// Method called when close bracket button is pressed
//-----------------------------------------------------
- (IBAction)On_Close_Bracket:(id)sender
{
    [self On_RegOp:CLOSE_BRACKET];
    was_last_close_bracket = YES;
}

//-----------------------------------------------------
// Method called when sin button is pressed
//-----------------------------------------------------
- (IBAction)On_Sin:(id)sender
{
    [self On_RegOp:SIN];
}

//-----------------------------------------------------
// Method called when cos button is pressed
//-----------------------------------------------------
- (IBAction)On_Cos:(id)sender
{
    [self On_RegOp:COS];
}

//-----------------------------------------------------
// Method called when tan button is pressed
//-----------------------------------------------------
- (IBAction)On_Tan:(id)sender
{
    [self On_RegOp:TAN];
}

//-----------------------------------------------------
// Method called when log button is pressed
//-----------------------------------------------------
- (IBAction)On_Log:(id)sender
{
    [self On_RegOp:LOG];
}

//-----------------------------------------------------
// Method called when ln button is pressed
//-----------------------------------------------------
- (IBAction)On_Ln:(id)sender
{
    [self On_RegOp:LN];
}

//-----------------------------------------------------
// Method called when sqrt button is pressed
//-----------------------------------------------------
- (IBAction)On_Root:(id)sender
{
    [self On_RegOp:ROOT];
}

//-----------------------------------------------------
// Method called when e^x button is pressed
//-----------------------------------------------------
- (IBAction)On_E:(id)sender
{
    [self On_RegOp:E_POW];
}

//-----------------------------------------------------
// Method called when addition button is pressed
//-----------------------------------------------------
- (IBAction) On_Plus:(id)sender
{
    [self On_RegOp:PLUS];
}

//-----------------------------------------------------
// Method called when subtraction button is pressed
//-----------------------------------------------------
- (IBAction) On_Minus:(id)sender
{
    [self On_RegOp:MINUS];
}

//-----------------------------------------------------
// Method called when multiplication button is pressed
//-----------------------------------------------------
- (IBAction) On_Mult:(id)sender
{
    [self On_RegOp:MULT];
}

//-----------------------------------------------------
// Method called when division button is pressed
//-----------------------------------------------------
- (IBAction) On_Div:(id)sender
{
    [self On_RegOp:DIV];
}

//-----------------------------------------------------
// Method called when power button is pressed
//-----------------------------------------------------
- (IBAction) On_Pow:(id)sender
{
    [self On_RegOp:POW];
}

//-----------------------------------------------------
// Generic number method
//-----------------------------------------------------
- (void) On_RegNum:(NSString *)s
{
    operator_called = NO;
    
    // case where user wants to start a new equation after computation of previous
    if (equals_was_last_called) {
        [self resetAll];
        equals_was_last_called = NO;
    }
    
    // if decimal, and no number before it.
//    if ([s isEqualToString:@"."] && [current_value isEqualToString:@""]) {
//        // if decimal with no number input before it
//        [self UpdateCurrentValueWithString:@"0."];
//    } else {
        [self AppendToCurrentValueWithString:s];
//    }
    
    [equation setStringValue:[[equation stringValue] stringByAppendingString:s]];
}

//-----------------------------------------------------
// Generic operator method
//-----------------------------------------------------
- (void) On_RegOp:(NSString *)op
{
    // want a regular operator to continue the equation
    if (equals_was_last_called) {
        
        // however, if the operator is a function or bracket, 
        if ([Equation doesOpOpenBracket:op]) {
            [self UpdateCurrentValueWithString:@""];
        }
        
        [equation setStringValue:current_value];
    }
    
    equals_was_last_called = NO;
    
    /* add preceding number to equation string */
    
    if ((![Equation doesOpOpenBracket:op] && !was_last_close_bracket) ||
         ([Equation doesOpOpenBracket:op] && !was_last_close_bracket && ![current_value isEqualToString:@""])
        ) {
        
        /* check current value */
        if (![current_value isEqualToString:@""]) {
            [e appendStringToEquation:[NSString stringWithString:current_value]];
        }
        else { // is there a better way to do this? the other if doesn't work.
            [e appendStringToEquation:ZERO];
            [equation setStringValue:ZERO];
        }
    }
    
    [self UpdateCurrentValueWithString:@""];
    [answer_box setStringValue:ZERO];
    
    /* write the operator to the equation line */
    [equation setStringValue:[[equation stringValue] stringByAppendingString:op]];
    
    operator_called = YES;
    decimal_placed = NO;
    was_last_close_bracket = NO;

    /* add current operator to the operators array */
    [e appendStringToEquation:op];
}

//-----------------------------------------------------
// Method called when equals button is pressed
//-----------------------------------------------------
- (IBAction) On_Equals:(id)sender
{
    // if user has pressed equals twice, we don't want to compute twice, so only perform operation
    // on the first time equals was last called
    if (!equals_was_last_called) {
        
        // this will put the last item into the equation. if 
        if (!was_last_close_bracket) {
            
            // add current_value to eq array
            [e appendStringToEquation:current_value];
        }

        equals_was_last_called = YES;
        
        NSNumber *result = [e performShuntingYardComputation];
        
        // check to see if result is not nil, otherwise catch and display error.
        if (result) {
            [self UpdateCurrentValueWithString:[result stringValue]];
        }
        else {
            [self resetAll];
            [self WriteToAnswerBox:ERROR_STRING];
        }
        
        was_last_close_bracket = NO;
    }
}

//-----------------------------------------------------
// Sets the string displayed in the answer box to the
// NSString specified by str
//-----------------------------------------------------
- (void) WriteToAnswerBox:(NSString *)str
{
    [answer_box setStringValue:str];
}

//-----------------------------------------------------
// Appends to the variable current_value with NSString s
//-----------------------------------------------------
- (void) AppendToCurrentValueWithString:(NSString *)s
{
    if (! [current_value isEqualToString:ZERO]) {
        [current_value appendString:s];
    }
    else { // current_value == 0, don't want to append multiple 0's
        [self UpdateCurrentValueWithString:s];
    }
    
    // simply copy string of current_value to be displayed in the answer box
    [self WriteToAnswerBox:current_value];
}

//-----------------------------------------------------
// Updates the variable current_value to a specified NSString s
//-----------------------------------------------------
- (void) UpdateCurrentValueWithString:(NSString *)s
{
    [current_value setString:s];

    // simply copy string of current_value to be displayed in the answer box
    [self WriteToAnswerBox:current_value];
}

@end




