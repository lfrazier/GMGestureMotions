//
//  GMFeatureExtractor.h
//  GMGestureMotions
//
//  Created by Lauren Frazier on 1/25/13.
//  Copyright (c) 2017 Lauren Frazier. All rights reserved.
//

@import Foundation;

#import "GMGesture.h"

/// Extracts features from gestures and returns stripped down sampled versions of gestures.
@protocol GMFeatureExtractor <NSObject>

/// Samples the signal and returns a sampled version.
- (GMGesture *)sampleSignal:(GMGesture *)signal;

@end
