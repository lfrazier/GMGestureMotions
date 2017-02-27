//
//  GMDTWAlgorithm.h
//  GMGestureMotions
//
//  Created by Lauren Frazier on 1/25/13.
//  Copyright (c) 2017 Lauren Frazier. All rights reserved.
//

@import Foundation;

#import "GMGesture.h"

/// Dynamic Time Warping algorithm implementation that calculates a value representing the
/// distance between two temporal sequences (in this case, gestures).
@interface GMDTWAlgorithm : NSObject

/// Calculates the distance between gestures \a a and \a b.
+ (float)calcDistanceBetweenGesture:(GMGesture *)a andGesture:(GMGesture *)b;

@end
