//
//  GMGestureRecognition.h
//  GMGestureMotions
//
//  Created by Lauren Frazier on 1/25/13.
//  Copyright (c) 2017 Lauren Frazier. All rights reserved.
//

@import Foundation;

#import "GMGestureClassifier.h"
#import "GMGestureRecorder.h"
#import "GMNormedGridExtractor.h"

/// Handles gesture recording and recognition events.
@protocol GMGestureRecognitonDelegate <NSObject>

@optional

/// Called when a gesture is successfully learned.
- (void)gestureLearned:(NSString *)gestureName;

/// Called when a gesture is successfully recognized.
- (void)gestureRecognized:(GMDistribution *)distribution;

@optional

/// Called when a training set is successfully deleted.
- (void)trainingSetDeleted:(NSString *)trainingSetName;

@end

/// GMGestureRecognition handles recording and classifying gestures based on the phone's
/// accelerometer and gyroscope. There are two modes, learn mode and classification mode.
/// Learn mode records motions and saves them to a training set (which can be persisted on disk as a
/// plist), while classification mode
@interface GMGestureRecognition : NSObject 

@property(nonatomic, weak) id<GMGestureRecognitonDelegate> delegate;

+ (GMGestureRecognition *)sharedInstance;

/// Starts learn mode with the given \a trainingSetName and \a gestureName.
- (void)startLearnModeForGesture:(NSString *)gestureName inSet:(NSString *)trainingSetName;

/// Stops learn mode.
- (void)stopLearnMode;

/// Starts classification mode. Will attempt to recognize any gestures performed.
- (void)startClassificationModeWithTrainingSet:(NSString *)trainingSet;

/// Stops classification mode.
- (void)stopClassificationMode;

/// Gets all available gesture names for the given \a trainingSet.
- (NSArray<NSString *> *)getGestureListForTrainingSet:(NSString *)trainingSet;

/// Removes the given \a gestureName from the given \a trainingSetName.
- (void)deleteGesture:(NSString *)gestureName fromTrainingSet:(NSString *)trainingSetName;

/// Delete the training set with the given \a name.
- (void)deleteTrainingSet:(NSString *)name;

/// True if the recognizer is in learning mode.
- (BOOL)isLearning;

/// True if the recognizer is in classifying mode.
- (BOOL)isClassifying;

/// Sets the \a threshold for recognition. The higher the threshold, the more strict the
/// classifier will be. Values between 1 and 5 are typical.
- (void)setThreshold:(float)threshold;

@end
