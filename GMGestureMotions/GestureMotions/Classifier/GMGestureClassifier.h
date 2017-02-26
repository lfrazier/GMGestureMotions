//
//  GMGestureClassifier.h
//  GMGestureMotions
//
//  Created by Lauren Frazier on 1/25/13.
//  Copyright (c) 2017 Lauren Frazier. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GMFeatureExtractor.h"
#import "DTWAlgorithm.h"
#import "GMDistribution.h"

@interface GMGestureClassifier : NSObject {
    GMFeatureExtractor *featureExtractor;
    NSMutableArray *trainingSet;
    NSString *activeTrainingSet;
}

@property (nonatomic, retain) GMFeatureExtractor *featureExtractor;

- (id)initWithFeatureExtractor:(GMFeatureExtractor *)fE;
- (BOOL)commitData;
- (BOOL)trainData:(GMGesture *)signal inTrainingSet:(NSString *)trainingSetName;
- (void)loadTrainingSet:(NSString *)trainingSetName;
- (BOOL)checkForLabel:(NSString *)label inTrainingSet:(NSString *)trainingSetName;
- (BOOL)checkForTrainingSet:(NSString *)trainingSetName;
- (BOOL)deleteTrainingSet:(NSString *)trainingSetName;
- (BOOL)deleteLabel:(NSString *)labelName inTrainingSet:(NSString *)trainingSetName;
- (NSArray<NSString *> *)getLabels:(NSString *)trainingSetName;
- (GMDistribution *)classifySignalInTrainingSet:(NSString *)trainingSetName withGesture:(GMGesture *)signal;

@end
