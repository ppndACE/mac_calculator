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

- (Stack*) init
{
    _stack = [NSMutableArray array];
    return [super init];
}

// method returns count according to current_count var
- (NSUInteger) count
{
    return [_stack count];
}

- (id) objectAtIndex:(NSUInteger)index
{
    return [_stack objectAtIndex:index];
}

// method returns TRUE when there are no elements stored in the stack
- (BOOL)isEmpty
{
    // check to see whether there are 0 elements stored in the array
    if ([self count] <= 0) {
        return TRUE;
    }
    
    return FALSE;
}

// method pops off last object in the stack
- (NSObject*)pop
{
    if ([self isEmpty]) {
        return nil;
    }

    // store last object in stack, remove it from stack, then return it
    NSObject* lastobj = [_stack lastObject];
    [_stack removeLastObject];
    
    return lastobj;
}

// method pushes new object onto the stack
- (void)push:(NSObject*)item
{
    [_stack addObject:item];
}

- (NSObject*)peek
{
    return [_stack lastObject];
}

- (void) removeAllObjects
{
    [_stack removeAllObjects];
}

@end




