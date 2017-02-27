//
//  GMDTWAlgorithm.m
//  GMGestureMotions
//
//  Created by Lauren Frazier on 1/25/13.
//  Copyright (c) 2017 Lauren Frazier. All rights reserved.
//

#import "GMDTWAlgorithm.h"

@implementation GMDTWAlgorithm

static float OFFSET_PENALTY = 0.5f;

+ (float)pnormWithVector:(NSArray *)vector andP:(int)p {
    float result = 0;
    float sum;
    for (NSNumber *b in vector) {
        sum = 1;
        for (int i = 0; i < p; ++i) {
            sum *= [b doubleValue];
        }
        result += sum;
    }
    return (float)powf(result, 1.0 / p);
}

+ (float)calcDistanceBetweenGesture:(GMGesture *)a andGesture:(GMGesture *)b {
    int signalDimensions = [[a.values objectAtIndex:0] count];
    int signal1Length = [a length];
    int signal2Length = [b length];
    
    // initialize matrices
    NSMutableArray *distMatrix = [NSMutableArray arrayWithCapacity:signal1Length];
    NSMutableArray *costMatrix = [NSMutableArray arrayWithCapacity:signal1Length];
    
    for (int i = 0; i < signal1Length; ++i) {
        distMatrix[i] = [NSMutableArray arrayWithCapacity:signal2Length];
        costMatrix[i] = [NSMutableArray arrayWithCapacity:signal2Length];
    }
    
    NSMutableArray *vec;
    
    // calculate distances
    for (int i = 0; i < signal1Length; ++i) {
        for (int j = 0; j < signal2Length; ++j) {
            vec = [NSMutableArray array];
            for (int k = 0; k < signalDimensions; ++k) {
                double d = [a getValueAtIndex:i dimension:k] - [b getValueAtIndex:j dimension:k];
                [vec addObject:[NSNumber numberWithDouble:d]];
            }
            distMatrix[i][j] = [NSNumber numberWithFloat:[self pnormWithVector:vec andP:2]];
        }
    }
    
    // genetic algorithm to find the best path
    for (int i = 0; i < signal1Length; ++i) {
        costMatrix[i][0] = distMatrix[i][0];
    }
    for (int j = 1; j < signal2Length; ++j) {
        for (int i = 0; i < signal1Length; ++i) {
            if (i == 0) {
                costMatrix[i][j] = [NSNumber numberWithFloat:[costMatrix[i][j -1] floatValue] + [distMatrix[i][j] floatValue]];
            } else {
                float minCost, cost;
                // i - 1, j - 1
                minCost = [costMatrix[i - 1][j - 1] floatValue] + [distMatrix[i][j] floatValue];
                
                // i - 1, j
                if ((cost = [costMatrix[i - 1][j] floatValue] + [distMatrix[i][j] floatValue]) < minCost) {
                    minCost = cost + OFFSET_PENALTY;
                }
                
                // i, j-1
                if ((cost = [costMatrix[i][j - 1] floatValue] + [distMatrix[i][j] floatValue]) < minCost) {
                    minCost = cost + OFFSET_PENALTY;
                }
                costMatrix[i][j] = [NSNumber numberWithFloat:minCost];
            }
        }
    }
    
    return [costMatrix[signal1Length - 1][signal2Length - 1] floatValue];
}

@end
