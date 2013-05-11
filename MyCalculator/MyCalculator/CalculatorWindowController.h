//
//  CalculatorWindowController.h
//  MyCalculator
//
//  Created by Matthew McAllister on 2013-05-10.
//  Copyright (c) 2013 Matthew McAllister. All rights reserved.
//

#import <Cocoa/Cocoa.h>

typedef enum _OPERATOR{
    eNONE,
    PLUS,
    MINUS,
    MULT,
    DIV
} eOPERATOR;

@interface CalculatorWindowController : NSWindowController
{
    double current_value;
    double first;
    double second;
    
    BOOL operator_called;
    BOOL equals_was_last_called;
    BOOL decimal_placed;
    
    eOPERATOR operators;
}

@property (weak) IBOutlet NSTextField *answer_box;

- (id) init;
- (id) initWithWindow:(NSWindow *)window;
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

/********************* Operators *********************/
- (IBAction) On_Plus:(id)sender;
- (IBAction) On_Minus:(id)sender;
- (IBAction) On_Mult:(id)sender;
- (IBAction) On_Div:(id)sender;

- (IBAction) On_Equals:(id)sender;



@end
