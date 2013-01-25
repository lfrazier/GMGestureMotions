//
//  GMFeatureExtractor.m
//  iOSGestureMotions
//
//  Created by Lauren Frazier on 1/25/13.
//  Copyright (c) 2013 Lauren Frazier. All rights reserved.
//

#import "GMFeatureExtractor.h"

@implementation GMFeatureExtractor

// OVERRIDE THIS IN SUBCLASSES
- (GMGesture *)sampleSignal:(GMGesture *)signal {
    return signal;
}

@end
