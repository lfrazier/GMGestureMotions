//
//  GMNormedGridExtractor.h
//  GMGestureMotions
//
//  Created by Lauren Frazier on 2/2/13.
//  Copyright (c) 2017 Lauren Frazier. All rights reserved.
//

#import "GMFeatureExtractor.h"
#import "GMNormExtractor.h"
#import "GMGridExtractor.h"

/// Both normalizes and trims a given signal to a certain number of steps and certain bounds.
@interface GMNormedGridExtractor : NSObject<GMFeatureExtractor>

@end
