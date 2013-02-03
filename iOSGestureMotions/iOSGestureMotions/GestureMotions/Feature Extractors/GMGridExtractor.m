//
//  GMGridExtractor.m
//  iOSGestureMotions
//
//  Created by Lauren Frazier on 2/2/13.
//  Copyright (c) 2013 Lauren Frazier. All rights reserved.
//

#import "GMGridExtractor.h"

@implementation GMGridExtractor

#define SAMPLE_STEPS 32

- (GMGesture *)sampleSignal:(GMGesture *)signal {
    NSMutableArray *sampledValues = [NSMutableArray arrayWithCapacity:SAMPLE_STEPS];
    float findex;
    GMGesture *sampledSignal = [[GMGesture alloc] initWithValues:sampledValues andLabel:signal.label];
    for (int j =0; j < SAMPLE_STEPS; ++j) {
        [sampledValues addObject:[NSMutableArray arrayWithCapacity:3]];
        for (int i = 0; i < 3; ++i) {
            findex = (float)([signal length] - 1) * j / (SAMPLE_STEPS - 1);
            float res = findex - (int)findex;
            [sampledSignal setValueAtIndex:j dimension:i value:(1 - res) * [signal getValueAtIndex:(int)findex dimension:i] + ((int)findex + 1 < [signal length] - 1 ? res * [signal getValueAtIndex:(int)findex + 1 dimension:i] : 0)];
        }
    }
    return sampledSignal;
}

@end
