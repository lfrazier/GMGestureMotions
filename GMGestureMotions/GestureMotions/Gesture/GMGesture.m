//
//  GMGesture.m
//  GMGestureMotions
//
//  Created by Lauren Frazier on 1/25/13.
//  Copyright (c) 2017 Lauren Frazier. All rights reserved.
//

#import "GMGesture.h"

@implementation GMGesture

- (id)initWithValues:(NSArray *)values andLabel:(NSString *)labelString {
    if (self = [super init] ) {
        _values = values;
        _label = labelString;
    }
    return self;
}

- (void)setValueAtIndex:(NSUInteger)index dimension:(NSUInteger)dimension value:(float)value {
  _values[index][dimension] = @(value);
}

- (float)getValueAtIndex:(NSUInteger)index dimension:(NSUInteger)dimension {
  NSNumber *value = _values[index][dimension];
  return [value floatValue];
}

- (NSUInteger)length {
  return [_values count];
}

@end
