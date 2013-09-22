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
- (void) resetExceptForAnswerBox
{
    [current_value setString:@""];
    [equation setStringValue:@""];
    
    operator_called = NO;
    //equals_was_last_called = NO;
    decimal_placed = NO;
    close_bracket_equals = NO;
    was_last_close_bracket = NO;
    
    [e reset];
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
    close_bracket_equals = NO;
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
// -- on delete key press, delete last character inputted
//-----------------------------------------------------
- (IBAction) On_Delete:(id)sender
{
    if (equals_was_last_called || operator_called) {
        return;
    }
    
    NSUInteger len = [current_value length];
    if (len == 0) {
        return;
    }
    
    if (len > 0) {
        [equation setStringValue:[[equation stringValue] substringToIndex:[[equation stringValue] length] - 1]];
    }
//    else {
//        [equation setStringValue:@""];
//    }
    
    if ([current_value length] == 1) {
        [self UpdateCurrentValueWithString:[current_value substringToIndex:[current_value length] - 1]];
        [answer_box setStringValue:@"0"];
    }
    else if ([current_value length] > 0) {
        [self UpdateCurrentValueWithString:[current_value substringToIndex:[current_value length] - 1]];
    }
    // else do nothing
}

//-----------------------------------------------------
// Method called when 0 button is pressed
//-----------------------------------------------------
- (IBAction) On_0:(id)sender
{
    NSString *num = ZERO;
    
    [self On_RegNum:num];
}

//-----------------------------------------------------
// Method called when 1 button is pressed
//-----------------------------------------------------
- (IBAction) On_1:(id)sender
{
    NSString *num = ONE;
    
    [self On_RegNum:num];
}

//-----------------------------------------------------
// Method called when 2 button is pressed
//-----------------------------------------------------
- (IBAction) On_2:(id)sender
{
    NSString *num = TWO;
    
    [self On_RegNum:num];
}

//-----------------------------------------------------
// Method called when 3 button is pressed
//-----------------------------------------------------
- (IBAction) On_3:(id)sender
{
    NSString *num = THREE;
    
    [self On_RegNum:num];
}

//-----------------------------------------------------
// Method called when 4 button is pressed
//-----------------------------------------------------
- (IBAction) On_4:(id)sender
{
    NSString *num = FOUR;
    
    [self On_RegNum:num];
}

//-----------------------------------------------------
// Method called when 5 button is pressed
//-----------------------------------------------------
- (IBAction) On_5:(id)sender
{
    NSString *num = FIVE;
    
    [self On_RegNum:num];
}

//-----------------------------------------------------
// Method called when 6 button is pressed
//-----------------------------------------------------
- (IBAction) On_6:(id)sender
{
    NSString *num = SIX;
    
    [self On_RegNum:num];
}

//-----------------------------------------------------
// Method called when 7 button is pressed
//-----------------------------------------------------
- (IBAction) On_7:(id)sender
{
    NSString *num = SEVEN;
    
    [self On_RegNum:num];
}

//-----------------------------------------------------
// Method called when 8 button is pressed
//-----------------------------------------------------
- (IBAction) On_8:(id)sender
{
    NSString *num = EIGHT;
    
    [self On_RegNum:num];
}

//-----------------------------------------------------
// Method called when 9 button is pressed
//-----------------------------------------------------
- (IBAction) On_9:(id)sender
{
    NSString *num = NINE;
    
    [self On_RegNum:num];
}

//-----------------------------------------------------
// Method called when decimal button is pressed
//-----------------------------------------------------
- (IBAction) On_Decimal:(id)sender
{
    if (!decimal_placed) {
        NSString *num = @".";
        [self On_RegNum:num];
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
}

//-----------------------------------------------------
// Method called when sin button is pressed
//-----------------------------------------------------
- (IBAction)On_Sin:(id)sender
{
    
}

//-----------------------------------------------------
// Method called when cos button is pressed
//-----------------------------------------------------
- (IBAction)On_Cos:(id)sender
{
    
}

//-----------------------------------------------------
// Method called when tan button is pressed
//-----------------------------------------------------
- (IBAction)On_Tan:(id)sender
{
    
}

//-----------------------------------------------------
// Method called when log button is pressed
//-----------------------------------------------------
- (IBAction)On_Log:(id)sender
{
    
}

//-----------------------------------------------------
// Method called when ln button is pressed
//-----------------------------------------------------
- (IBAction)On_Ln:(id)sender
{
    
}

//-----------------------------------------------------
// Method called when sqrt button is pressed
//-----------------------------------------------------
- (IBAction)On_Root:(id)sender
{
    //[self On_RegOp:@"√"];
}

//-----------------------------------------------------
// Method called when e^x button is pressed
//-----------------------------------------------------
- (IBAction)On_E:(id)sender
{
    
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
    
    [self AppendToCurrentValueWithString:s];
    [equation setStringValue:[[equation stringValue] stringByAppendingString:s]];
}

//-----------------------------------------------------
// Generic operator method
//-----------------------------------------------------
- (void) On_RegOp:(NSString *)op
{

//TODO: probably something here to check stuff
    if ([op isEqualToString:CLOSE_BRACKET]) {
        close_bracket_equals = YES;
    }
    else {
        close_bracket_equals = NO;
    }
    
    if (equals_was_last_called) {
        [equation setStringValue:current_value];
    }
    
    equals_was_last_called = NO;
    
    /* add preceding number to equation string */
    
    if (![op isEqualToString:@"("] && !was_last_close_bracket) {
        
//        if ([current_value isEqualToString:@""]) {
//            [self On_RegNum:@"0"];
//        }
        
        [e appendStringToEquation:[NSString stringWithString:current_value]];
        
    }
    
    [self UpdateCurrentValueWithString:@""];
    [answer_box setStringValue:@"0"];
    
    /* write the operator to the equation line */
    [equation setStringValue:[[equation stringValue] stringByAppendingString:op]];
    
    operator_called = YES;
    decimal_placed = NO;
    
    if (!close_bracket_equals) {
        was_last_close_bracket = NO;
    }
    if ([op isEqualToString:@")"]) {
        was_last_close_bracket = YES;
    }
    
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
        if (!close_bracket_equals) {
            // add current_value to eq array
            [e appendStringToEquation:current_value];
        }

        equals_was_last_called = YES;
        
        NSNumber *result = [e performShuntingYardComputation];
        
        [self UpdateCurrentValueWithString:[result stringValue]];
        
        was_last_close_bracket = NO;
    }
}

//-----------------------------------------------------
// Logic for appending a value to the answer box
//-----------------------------------------------------
- (void) WriteToAnswerBox:(NSString *)i
{
//    if ([[answer_box stringValue] isEqualToString:@"0"]) { /* if value is 0, replace it, otherwise append */
//        [answer_box setStringValue:i];
//    }
//    else { /* includes case where decimal has been placed */
//        
//        if (equals_was_last_called) {
//            [self resetAll];
//            [self On_RegNum:i];
//            [answer_box setStringValue:i];
//        }
//        else {
//            [answer_box setStringValue:[[answer_box stringValue] stringByAppendingString:i]];
//        }
//    }
//    
//    NSString *answer = [answer_box stringValue];
//    
//    if (equals_was_last_called){
//        [self resetExceptForAnswerBox];
//        //equals_was_last_called = NO;
//    }
//
//    return answer;
    
    [answer_box setStringValue:current_value];
}

//-----------------------------------------------------
// Appends to the variable current_value with NSString s
//-----------------------------------------------------
- (void) AppendToCurrentValueWithString:(NSString *)s
{
    if ([s isEqualToString:@"."] && [current_value isEqualToString:@""]) {
        [self UpdateCurrentValueWithString:@"0."];
    }
    else if (! [current_value isEqualToString:@"0"]) {
        [current_value appendString:s];
    }
    else { // current_value == 0
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




