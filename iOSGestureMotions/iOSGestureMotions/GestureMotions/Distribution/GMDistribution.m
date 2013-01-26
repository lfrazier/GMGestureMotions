//
//  GMDistribution.m
//  iOSGestureMotions
//
//  Created by Lauren Frazier on 1/25/13.
//  Copyright (c) 2013 Lauren Frazier. All rights reserved.
//

#import "GMDistribution.h"

@implementation GMDistribution

- (id)init {
    if (self = [super init]) {
        distribution = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)addEntryWithTag:(NSString *)tag distance:(double)distance {
    [distribution setObject:[NSNumber numberWithDouble:distance] forKey:tag];
    if (distance < minDistance) {
        minDistance = distance;
        best = tag;
    }
}

- (NSString *)getBestMatch {
    return best;
}

- (double)getBestDistance {
    return minDistance;
}

- (int)size {
    return [distribution count];
}

@end
