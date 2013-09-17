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
    self = [super initWithWindowNibName:@"CalculatorWindowController"];
    
    levels_of_brackets = 0;
    
    numbers = [[NSMutableArray alloc] init];
    operators = [[NSMutableArray alloc] init];
    
    NSArray *keys = [NSArray arrayWithObjects:@"POW", @"MULT", @"DIV", @"PLUS", @"MINUS", nil];
    NSArray *objects = [NSArray arrayWithObjects:[NSNumber numberWithInt:0], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:2], [NSNumber numberWithInt:2], nil];
    dict = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
    
    return self;
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
    [equation setStringValue:@""];
    current_value = 0;
    
    operator_called = NO;
    //equals_was_last_called = NO;
    decimal_placed = NO;
    
    [numbers removeAllObjects];
    [operators removeAllObjects];
}

//-----------------------------------------------------
// Sets all member vars and display to 0
//-----------------------------------------------------
- (void) resetAll
{
    [answer_box setStringValue:@"0"];
    [equation setStringValue:@""];
    current_value = 0;
    
    operator_called = NO;
    equals_was_last_called = NO;
    decimal_placed = NO;
    
    [numbers removeAllObjects];
    [operators removeAllObjects];
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
    NSString *s = [answer_box stringValue];
    
    if ([s length] - 1 != 0) {
        [answer_box setStringValue:[s substringToIndex:[s length] - 1]];
        [equation setStringValue:[[equation stringValue] substringToIndex:[[equation stringValue] length] - 1]];
    }
    else {
        [answer_box setStringValue:@"0"];
        [equation setStringValue:@""];
    }
    
    [self UpdateCurrentValue];
}

//-----------------------------------------------------
// Method called when 0 button is pressed
//-----------------------------------------------------
- (IBAction) On_0:(id)sender
{
    NSString *num = @"0";
    
    [self On_RegNum:num];
    [self WriteToAnswerBox:num];
}

//-----------------------------------------------------
// Method called when 1 button is pressed
//-----------------------------------------------------
- (IBAction) On_1:(id)sender
{
    NSString *num = @"1";
    
    [self On_RegNum:num];
    [self WriteToAnswerBox:num];
}

//-----------------------------------------------------
// Method called when 2 button is pressed
//-----------------------------------------------------
- (IBAction) On_2:(id)sender
{
    NSString *num = @"2";
    
    [self On_RegNum:num];
    [self WriteToAnswerBox:num];
}

//-----------------------------------------------------
// Method called when 3 button is pressed
//-----------------------------------------------------
- (IBAction) On_3:(id)sender
{
    NSString *num = @"3";
    
    [self On_RegNum:num];
    [self WriteToAnswerBox:num];
}

//-----------------------------------------------------
// Method called when 4 button is pressed
//-----------------------------------------------------
- (IBAction) On_4:(id)sender
{
    NSString *num = @"4";
    
    [self On_RegNum:num];
    [self WriteToAnswerBox:num];
}

//-----------------------------------------------------
// Method called when 5 button is pressed
//-----------------------------------------------------
- (IBAction) On_5:(id)sender
{
    NSString *num = @"5";
    
    [self On_RegNum:num];
    [self WriteToAnswerBox:num];
}

//-----------------------------------------------------
// Method called when 6 button is pressed
//-----------------------------------------------------
- (IBAction) On_6:(id)sender
{
    NSString *num = @"6";
    
    [self On_RegNum:num];
    [self WriteToAnswerBox:num];
}

//-----------------------------------------------------
// Method called when 7 button is pressed
//-----------------------------------------------------
- (IBAction) On_7:(id)sender
{
    NSString *num = @"7";
    
    [self On_RegNum:num];
    [self WriteToAnswerBox:num];
}

//-----------------------------------------------------
// Method called when 8 button is pressed
//-----------------------------------------------------
- (IBAction) On_8:(id)sender
{
    NSString *num = @"8";
    
    [self On_RegNum:num];
    [self WriteToAnswerBox:num];
}

//-----------------------------------------------------
// Method called when 9 button is pressed
//-----------------------------------------------------
- (IBAction) On_9:(id)sender
{
    NSString *num = @"9";
    
    [self On_RegNum:num];
    [self WriteToAnswerBox:num];
}

//-----------------------------------------------------
// Method called when decimal button is pressed
//-----------------------------------------------------
- (IBAction) On_Decimal:(id)sender
{
    if (!decimal_placed) {
        NSString *num = @".";
        [self On_RegNum:num];
        [self WriteToAnswerBox:num];
        decimal_placed = YES;
    }
}

//-----------------------------------------------------
// Method called when open bracket button is pressed
//-----------------------------------------------------
- (IBAction)On_Open_Bracket:(id)sender
{
    levels_of_brackets += 1;
    [self On_RegBracket:@"("];
}

//-----------------------------------------------------
// Method called when close bracket button is pressed
//-----------------------------------------------------
- (IBAction)On_Close_Bracket:(id)sender
{
    if (levels_of_brackets > 0) {
        levels_of_brackets -=1;
    }
    
    [self On_RegBracket:@")"];
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
    [self On_RegOp:PLUS withString:@"+"];
}

//-----------------------------------------------------
// Method called when subtraction button is pressed
//-----------------------------------------------------
- (IBAction) On_Minus:(id)sender
{
    [self On_RegOp:MINUS withString:@"-"];
}

//-----------------------------------------------------
// Method called when multiplication button is pressed
//-----------------------------------------------------
- (IBAction) On_Mult:(id)sender
{
    [self On_RegOp:MULT withString:@"*"];
}

//-----------------------------------------------------
// Method called when division button is pressed
//-----------------------------------------------------
- (IBAction) On_Div:(id)sender
{
    [self On_RegOp:DIV withString:@"/"];
}

//-----------------------------------------------------
// Method called when power button is pressed
//-----------------------------------------------------
- (IBAction) On_Pow:(id)sender
{
    [self On_RegOp:POW withString:@"^"];
}

//-----------------------------------------------------
// Generic number method
//-----------------------------------------------------
- (void) On_RegNum:(NSString *)s
{
    [equation setStringValue:[[equation stringValue] stringByAppendingString:s]];
}

//-----------------------------------------------------
// Generic operator method
//-----------------------------------------------------
- (void) On_RegOp:(NSString *)op withString:(NSString *)s
{
//    [equation setStringValue:[NSString stringWithFormat:@"%f", current_value]];
    
    /* write the operator to the equation line */
    [equation setStringValue:[[equation stringValue] stringByAppendingString:s]];
    
    /* add previous number to the numbers array */
    [numbers addObject:[NSNumber numberWithDouble:current_value]];
    
    operator_called = YES;
    
    /* add current operator to the operators array */
    [operators addObject:op];
}

//-----------------------------------------------------
// Generic bracket method
//-----------------------------------------------------
- (void) On_RegBracket:(NSString *)s
{
    /* write the bracket to the equation line */
    [equation setStringValue:[[equation stringValue] stringByAppendingString:s]];
    
    /* add previous number to the numbers array */
    [numbers addObject:[NSNumber numberWithDouble:current_value]];
}

//-----------------------------------------------------
// Method called when equals button is pressed
//-----------------------------------------------------
- (IBAction) On_Equals:(id)sender
{    
    equals_was_last_called = YES;
    
    [numbers addObject:[NSNumber numberWithDouble:current_value]];
    
    operator_called = YES;
    
    for (int i = 0; i < _OPERATOR_COUNT; i++) {
        
        for (int j = 0; j < [operators count]; j++) {
            
            /* evaluates, remove operator, remove second number, replace first number with result */
            NSNumber *val = [dict valueForKey:[operators objectAtIndex:j]];
            
            if ([val intValue] != i) {
                continue;
            }
            
            NSString *op = [operators objectAtIndex:j];
            
            NSNumber *n = [self EvaluateExpWithOp:op atIndex:j];
            
            [operators removeObjectAtIndex:j];
            [numbers removeObjectAtIndex:(j + 1)];
            [numbers replaceObjectAtIndex:j withObject:n];
            
            /* break out of loop if there are no more numbers left */
            if ([numbers count] == 1) {
                break;
            }
            
            /* since we are removing the current object from the operators array, we need */
            /* to re-check this entry since it will be filled with another entry */
            j--;
        }
    }
    
    /* last remaining value in numbers array should be the actual result */
    NSString *result = [[numbers objectAtIndex:0] stringValue];
    [self WriteToAnswerBox:result];
}

//-----------------------------------------------------
// Evaluates one expression (one operator)
//-----------------------------------------------------
- (NSNumber *) EvaluateExpWithOp:(NSString *)op atIndex:(NSInteger)i
{
    NSNumber *result = nil;
    
    /* determines which operation to run depending on input */
    /* runs on the number with same index as operator & one after */
    if ([op isEqualToString:PLUS]) {
        result = [NSNumber numberWithDouble:([[numbers objectAtIndex:i] doubleValue] + [[numbers objectAtIndex:(i + 1)]doubleValue])];
    }
    else if ([op isEqualToString:MINUS]) {
        result = [NSNumber numberWithDouble:([[numbers objectAtIndex:i] doubleValue] - [[numbers objectAtIndex:(i + 1)]doubleValue])];
    }
    else if ([op isEqualToString:MULT]) {
        result = [NSNumber numberWithDouble:([[numbers objectAtIndex:i] doubleValue] * [[numbers objectAtIndex:(i + 1)]doubleValue])];
    }
    else if ([op isEqualToString:DIV]) {
        result = [NSNumber numberWithDouble:([[numbers objectAtIndex:i] doubleValue] / [[numbers objectAtIndex:(i + 1)]doubleValue])];
    }
    else if ([op isEqualToString:POW]) {
        result = [NSNumber numberWithDouble:pow([[numbers objectAtIndex:i] doubleValue], [[numbers objectAtIndex:(i + 1)]doubleValue])];
    }
    else {
        //TODO: something?
    }
    
    /* return the evaluated operation as an NSNumber */
    return result;
}

//-----------------------------------------------------
// Logic for appending a value to the answer box
//-----------------------------------------------------
- (NSString *) WriteToAnswerBox:(NSString *)i
{
    if (operator_called) {
        decimal_placed = NO;
        [answer_box setStringValue:@"0"];
        current_value = 0;
        operator_called = NO;
    }
    
    if (current_value == 0) { /* if value is 0, replace it, otherwise append */
        [answer_box setStringValue:i];
    }
    else { /* includes case where decimal has been placed */
        
        if (equals_was_last_called) {
            [self resetAll];
            [self On_RegNum:i];
            [answer_box setStringValue:i];
        }
        else {
            [answer_box setStringValue:[[answer_box stringValue] stringByAppendingString:i]];
        }
    }
    
    NSString *answer = [answer_box stringValue];
    
    if (equals_was_last_called){
        [self resetExceptForAnswerBox];
        //equals_was_last_called = NO;
        [self UpdateCurrentValue];
        [self On_RegNum:answer];
    }
    else {
        [self UpdateCurrentValue];
    }
    
    return answer;
}

//-----------------------------------------------------
// Updates the variable curent_value according to the
// value stored in the answer box
//-----------------------------------------------------
- (void) UpdateCurrentValue
{
    current_value = [answer_box doubleValue];
}

@end




