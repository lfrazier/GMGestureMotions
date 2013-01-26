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

@interface GMGestureRecognition : NSObject {
    BOOL isLearning;
    BOOL isClassifying;
    GMGestureClassifier *classifier;
    GMGestureRecorder *recorder;
    NSString *activeTrainingSet;
    NSString *activeLearnLabel;
}

- (void)deleteTrainingSet:(NSString *)name;
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
