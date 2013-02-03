//
//  GMNormExtractor.m
//  iOSGestureMotions
//
//  Created by Lauren Frazier on 2/2/13.
//  Copyright (c) 2013 Lauren Frazier. All rights reserved.
//

#import "GMNormExtractor.h"

@implementation GMNormExtractor

- (GMGesture *)sampleSignal:(GMGesture *)signal {
    NSMutableArray *sampledValues = [NSMutableArray arrayWithCapacity:[signal length]];
    float min = FLT_MAX;
    float max = FLT_MIN;
    for (int i = 0; i < [signal length]; i++) {
        for (int j = 0; j < 3; j++) {
            if ([signal getValueAtIndex:i dimension:j] > max) {
                max = [signal getValueAtIndex:i dimension:j];
            }
            if ([signal getValueAtIndex:i dimension:j] < min) {
                min = [signal getValueAtIndex:i dimension:j];
            }
        }
    }
    
    GMGesture *sampledSignal = [[GMGesture alloc] initWithValues:sampledValues andLabel:signal.label];
    
    for (int i = 0; i < [signal length]; ++i) {
        [sampledValues addObject:[NSMutableArray arrayWithCapacity:3]];
        for (int j = 0; j < 3; ++j) {
            [sampledSignal setValueAtIndex:i dimension:j value:([signal getValueAtIndex:i dimension:j] - min) / (max - min)];
        }
    }
    return sampledSignal;
}

@end
