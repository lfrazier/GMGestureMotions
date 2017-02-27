//
//  GMDistribution.h
//  GMGestureMotions
//
//  Created by Lauren Frazier on 1/25/13.
//  Copyright (c) 2017 Lauren Frazier. All rights reserved.
//

@import Foundation;

/// Represents a distribution of gestures and distances from the original. Underlying mechanism is a
/// dictionary.
@interface GMDistribution : NSObject

/// Adds an entry with the given \a tag and \a distance value.
- (void)addEntryWithTag:(NSString *)tag distance:(double)distance;

/// Returns the tag of the best match in the distribution.
- (NSString *)getBestMatch;

/// Returns the distance of the best match in the distribution.
- (double)getBestDistance;

/// Returns the size of the distribution (number of entries).
- (NSUInteger)size;

@end
