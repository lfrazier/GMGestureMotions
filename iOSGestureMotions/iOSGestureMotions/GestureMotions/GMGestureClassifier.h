//
//  GMGestureClassifier.h
//  iOSGestureMotions
//
//  Created by Lauren Frazier on 1/25/13.
//  Copyright (c) 2013 Lauren Frazier. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GMFeatureExtractor.h"
#import "DTWAlgorithm.h"
#import "GMDistribution.h"

@interface GMGestureClassifier : NSObject {
    GMFeatureExtractor *featureExtractor;
    NSArray *trainingSet;
    NSString *activeTrainingSet;
}

@property (nonatomic, retain) GMFeatureExtractor *featureExtractor;

- (id)initWithFeatureExtractor:(GMFeatureExtractor *)fE;
- (GMDistribution *)classifySignal:(NSString *)trainingSetName withGesture:(GMGesture *)signal;

@end
