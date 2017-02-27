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
  GMGesture *grid = [[[GMGridExtractor alloc] init] sampleSignal:signal];
  GMGesture *normedGrid = [[[GMNormExtractor alloc] init] sampleSignal:grid];
  return normedGrid;
}

@end
