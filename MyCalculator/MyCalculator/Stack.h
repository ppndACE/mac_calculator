//
//  Stack.h
//  MyCalculator
//
//  Implementation of a LIFO stack using NSMutableArray.
//
//  Created by Matthew McAllister on 2013-09-18.
//  Copyright (c) 2013 Matthew McAllister. All rights reserved.
//

#ifndef _STACK_H_
#define _STACK_H_

#import <Foundation/Foundation.h>

@interface Stack : NSObject
{
    NSMutableArray *_stack;
}

- (NSUInteger) count;
- (BOOL) isEmpty;
- (NSObject *) pop;
- (void) push:(NSObject *)item;
- (NSObject *) peek;
- (void) removeAllObjects;

@end

#endif

