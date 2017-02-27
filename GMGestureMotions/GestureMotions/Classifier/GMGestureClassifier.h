//
//  GMGestureClassifier.h
//  GMGestureMotions
//
//  Created by Lauren Frazier on 1/25/13.
//  Copyright (c) 2017 Lauren Frazier. All rights reserved.
//

@import Foundation;
#import "GMFeatureExtractor.h"
#import "GMDTWAlgorithm.h"
#import "GMDistribution.h"

/// Classifies gestures using a feature extractor.
@interface GMGestureClassifier : NSObject

@property(nonatomic) GMFeatureExtractor *featureExtractor;

- (id)initWithFeatureExtractor:(GMFeatureExtractor *)featureExtractor;

/// Writes data to a plist.
- (BOOL)commitData;

/// Adds the given \a signal to the training set.
- (BOOL)trainData:(GMGesture *)signal inTrainingSet:(NSString *)trainingSetName;

/// Loads the given training set from disk.
- (void)loadTrainingSet:(NSString *)trainingSetName;

/// True if the given \a label exists in the given training set.
- (BOOL)checkForLabel:(NSString *)label inTrainingSet:(NSString *)trainingSetName;

/// True if there is a training set by the given \a trainingSetName.
- (BOOL)checkForTrainingSet:(NSString *)trainingSetName;

/// Deletes the training set with the given \a trainingSetName. True if deletion was successful.
- (BOOL)deleteTrainingSet:(NSString *)trainingSetName;

/// Deletes the given \a labelName from the training set. True if deletion was successful.
- (BOOL)deleteLabel:(NSString *)labelName inTrainingSet:(NSString *)trainingSetName;

/// Gets all the labels in the training set.
- (NSArray<NSString *> *)getLabels:(NSString *)trainingSetName;

/// Calculates a \c GMDistribution for the given \a signal in the training set.
- (GMDistribution *)classifySignalInTrainingSet:(NSString *)trainingSetName
                                    withGesture:(GMGesture *)signal;

@end
