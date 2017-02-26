//
//  GMGesture.h
//  GMGestureMotions
//
//  Created by Lauren Frazier on 1/25/13.
//  Copyright (c) 2017 Lauren Frazier. All rights reserved.
//

@import Foundation;

/// Represents a single gesture. A gesture has a name and a set of values along each dimension
/// (x, y, and z).
@interface GMGesture : NSObject

/// The name of the gesture.
@property(nonatomic, copy) NSString *label;

/// The values of this gesture. Two-dimensional array that contains values for x, y, and z.
@property(nonatomic) NSArray *values;

/// Creates a gesture with the given \a values and name.
- (id)initWithValues:(NSArray *)values andLabel:(NSString *)labelString;

/// Sets the \a value at the given \a index for the given \a dimension.
- (void)setValueAtIndex:(NSUInteger)index dimension:(NSUInteger)dimension value:(float)value;

/// Gets the value at the given \a index and \a dimension.
- (float)getValueAtIndex:(NSUInteger)index dimension:(NSUInteger)dimension;

/// The length of the gesture.
- (NSUInteger)length;

@end
