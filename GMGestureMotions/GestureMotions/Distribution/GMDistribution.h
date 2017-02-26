//
//  GMDistribution.h
//  GMGestureMotions
//
//  Created by Lauren Frazier on 1/25/13.
//  Copyright (c) 2013 Lauren Frazier. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GMDistribution : NSObject {
    NSString *best;
    double minDistance;
    NSMutableDictionary *distribution;
}

- (void)addEntryWithTag:(NSString *)tag distance:(double)distance;
- (NSString *)getBestMatch;
- (double)getBestDistance;
- (int)size;

@end
