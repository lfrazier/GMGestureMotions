//
//  GMGestureClassifier.m
//  iOSGestureMotions
//
//  Created by Lauren Frazier on 1/25/13.
//  Copyright (c) 2013 Lauren Frazier. All rights reserved.
//

#import "GMGestureClassifier.h"

@implementation GMGestureClassifier

@synthesize featureExtractor;

- (id)initWithFeatureExtractor:(GMFeatureExtractor *)fE {
    if ( self = [super init] ) {
        featureExtractor = fE;
    }
    return self;
}

- (void)loadTrainingSet:(NSString *)trainingSetName {
    return;
}

- (GMDistribution *)classifySignal:(NSString *)trainingSetName withGesture:(GMGesture *)signal {
    if (trainingSetName == nil) {
        NSLog(@"No Training Set Name specified");
    }
    if (![trainingSetName isEqual:activeTrainingSet]) {
        [self loadTrainingSet:trainingSetName];
    }
    
    if ([trainingSet count] == 0) {
        NSLog(@"No training data for training set %@", trainingSetName);
    }
    
    GMDistribution *distribution = [[GMDistribution alloc] init];
    GMGesture *sampledSignal = [featureExtractor sampleSignal:signal];
    
    for (GMGesture *s in trainingSet) {
        double dist = [DTWAlgorithm calcDistanceBetweenGesture:s andGesture:sampledSignal];
        [distribution addEntryWithTag:s.label distance:dist];
    }

    return distribution;
}


@end
