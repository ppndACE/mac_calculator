//
//  Stack.m
//  MyCalculator
//
//  Implementation of a LIFO stack using NSMutableArray.
//
//  Created by Matthew McAllister on 2013-09-18.
//  Copyright (c) 2013 Matthew McAllister. All rights reserved.
//

#import "Stack.h"

@implementation Stack

//-----------------------------------------------------
// Initializes Stack object and internal NSMutableArray _stack
//-----------------------------------------------------
- (Stack *) init
{
    _stack = [NSMutableArray array];
    return [super init];
}

//-----------------------------------------------------
// Method returns count of internal _stack array
//-----------------------------------------------------
- (NSUInteger) count
{
    return [_stack count];
}

//-----------------------------------------------------
// Returns the object at specified index in _stack
//-----------------------------------------------------
- (id) objectAtIndex:(NSUInteger)index
{
    return [_stack objectAtIndex:index];
}

//-----------------------------------------------------
// Method returns TRUE when there are no elements stored in the stack
//-----------------------------------------------------
- (BOOL) isEmpty
{
        // check to see whether there are 0 elements stored in the array
    
    if ([self count] <= 0) {
        return TRUE;
    }
    
    return FALSE;
}

//-----------------------------------------------------
// Method pops off last object in the stack
//-----------------------------------------------------
- (NSObject *) pop
{
        // if the stack is empty, return nil
    
    if ([self isEmpty]) {
        return nil;
    }

        // store last object in stack, remove it from stack, then return it
    
    NSObject* lastobj = [_stack lastObject];
    [_stack removeLastObject];
    
    return lastobj;
}

//-----------------------------------------------------
// Method pushes new object onto the stack
//-----------------------------------------------------
- (void) push:(NSObject *)item
{
    [_stack addObject:item];
}

//-----------------------------------------------------
// Returns last element in stack similarly to pop,
// except does not remove the object from stack
//-----------------------------------------------------
- (NSObject *) peek
{
    return [_stack lastObject];
}

//-----------------------------------------------------
// Removes all objects from the stack, effectively resetting it
//-----------------------------------------------------
- (void) removeAllObjects
{
    [_stack removeAllObjects];
}

@end




