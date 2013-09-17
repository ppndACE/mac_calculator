//
//  CalculatorWindowController.h
//  MyCalculator
//
//  Created by Matthew McAllister on 2013-05-10.
//  Copyright (c) 2013 Matthew McAllister. All rights reserved.
//

#ifndef _CALCULATOR_WINDOW_CONTROLLER_H_
#define _CALCULATOR_WINDOW_CONTROLLER_H_

#import <Cocoa/Cocoa.h>

#define _OPERATOR_COUNT 5
#define POW @"POW"
#define MULT @"MULT"
#define DIV @"DIV"
#define PLUS @"PLUS"
#define MINUS @"MINUS"


/* for now, this controls the order of operations and available operators */
//typedef enum _OPERATOR {
//    POW = @"POW",
//    MULT,
//    DIV,
//    PLUS,
//    MINUS
//} eOPERATOR;

@interface CalculatorWindowController : NSWindowController
{
    double current_value;
    int levels_of_brackets;
    
    BOOL operator_called;
    BOOL equals_was_last_called;
    BOOL decimal_placed;
    
    NSMutableArray *numbers;
    NSMutableArray *operators;
    
    NSDictionary *dict;
}

@property (weak) IBOutlet NSTextField *answer_box;
@property (weak) IBOutlet NSTextField *equation;

- (id) init;
- (void) windowDidLoad;

- (IBAction) On_Clear:(id)sender;
- (IBAction) On_Delete:(id)sender;

/********************* Numbers *********************/

- (IBAction) On_0:(id)sender;
- (IBAction) On_1:(id)sender;
- (IBAction) On_2:(id)sender;
- (IBAction) On_3:(id)sender;
- (IBAction) On_4:(id)sender;
- (IBAction) On_5:(id)sender;
- (IBAction) On_6:(id)sender;
- (IBAction) On_7:(id)sender;
- (IBAction) On_8:(id)sender;
- (IBAction) On_9:(id)sender;

- (IBAction) On_Decimal:(id)sender;

/********************* Brackets *********************/
- (IBAction)On_Open_Bracket:(id)sender;
- (IBAction)On_Close_Bracket:(id)sender;

/********************* Functions *********************/
- (IBAction)On_Sin:(id)sender;
- (IBAction)On_Cos:(id)sender;
- (IBAction)On_Tan:(id)sender;
- (IBAction)On_Log:(id)sender;
- (IBAction)On_Ln:(id)sender;
- (IBAction)On_Root:(id)sender;
- (IBAction)On_E:(id)sender;

/********************* Operators *********************/
- (IBAction) On_Plus:(id)sender;
- (IBAction) On_Minus:(id)sender;
- (IBAction) On_Mult:(id)sender;
- (IBAction) On_Div:(id)sender;
- (IBAction) On_Pow:(id)sender;

- (void) On_RegNum:(NSString *)s;
- (void) On_RegOp:(NSString *)op withString:(NSString *)s;
- (void) On_RegBracket:(NSString *)s;

- (IBAction) On_Equals:(id)sender;
- (NSNumber *) EvaluateExpWithOp:(NSString *)op atIndex:(NSInteger)i;



@end

#endif

