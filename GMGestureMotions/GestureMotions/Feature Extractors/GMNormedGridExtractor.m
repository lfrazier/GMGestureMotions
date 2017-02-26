//
//  GMNormedGridExtractor.m
//  GMGestureMotions
//
//  Created by Lauren Frazier on 2/2/13.
//  Copyright (c) 2017 Lauren Frazier. All rights reserved.
//

#import "GMNormedGridExtractor.h"

@implementation GMNormedGridExtractor

- (GMGesture *)sampleSignal:(GMGesture *)signal {
    GMGesture *s = [[[GMGridExtractor alloc] init] sampleSignal:signal];
    return [[[GMNormExtractor alloc] init] sampleSignal:s];
}

@end
