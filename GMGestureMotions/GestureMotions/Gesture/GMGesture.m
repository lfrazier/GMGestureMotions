//
//  GMGesture.m
//  GMGestureMotions
//
//  Created by Lauren Frazier on 1/25/13.
//  Copyright (c) 2013 Lauren Frazier. All rights reserved.
//

#import "GMGesture.h"

@implementation GMGesture

@synthesize label, values;

- (id)initWithValues:(NSArray *)vals andLabel:(NSString *)labelString {
    if ( self = [super init] ) {
        values = vals;
        label = labelString;
    }
    return self;
}

- (void)setValueAtIndex:(int)index dimension:(int)dim value:(float)val {
    [[values objectAtIndex:index] setObject:[NSNumber numberWithFloat:val] atIndex:dim];
}

- (float)getValueAtIndex:(int)index dimension:(int)dim {
    NSNumber *value = [[values objectAtIndex:index] objectAtIndex:dim];
    return [value floatValue];
}

- (int)length {
    return [values count];
}

@end
