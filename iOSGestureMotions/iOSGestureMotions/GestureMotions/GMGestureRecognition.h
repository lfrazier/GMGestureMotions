//
//  GMGestureRecognition.h
//  iOSGestureMotions
//
//  Created by Lauren Frazier on 1/25/13.
//  Copyright (c) 2013 Lauren Frazier. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GMGestureClassifier.h"
#import "GMGestureRecorder.h"
#import "GMNormedGridExtractor.h"

@protocol GMGestureRecognitonDelegate <NSObject>

- (void)trainingSetDeleted:(NSString *)trainingSetName;
- (void)gestureLearned:(NSString *)gestureName;
- (void)gestureRecognized:(GMDistribution *)distribution;

@end

@interface GMGestureRecognition : NSObject <GMGestureRecorderDelegate> {
    BOOL isLearning;
    BOOL isClassifying;
    GMGestureClassifier *classifier;
    GMGestureRecorder *recorder;
    NSString *activeTrainingSet;
    NSString *activeLearnLabel;
}

@property (nonatomic, retain) id<GMGestureRecognitonDelegate> delegate;

- (void)deleteTrainingSet:(NSString *)name;
- (void)pushToGesture;
- (void)startClassificationMode:(NSString *)trainingSetName;
- (void)startLearnMode:(NSString *)trainingSetName forGesture:(NSString *)gestureName;
- (void)stopLearnMode;
- (NSArray *)getGestureList:(NSString *)trainingSetName;
- (void)stopClassificationMode;
- (void)deleteGestureInSet:(NSString *)trainingSetName withName:(NSString *)gestureName;
- (BOOL)isLearning;
- (BOOL)isClassifying;
- (void)setThreshold:(float)threshold;
- (void)gestureRecorded:(NSArray *)values;


@end
