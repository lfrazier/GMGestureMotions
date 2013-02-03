//
//  GMGestureRecognition.m
//  iOSGestureMotions
//
//  Created by Lauren Frazier on 1/25/13.
//  Copyright (c) 2013 Lauren Frazier. All rights reserved.
//

#import "GMGestureRecognition.h"

@implementation GMGestureRecognition

@synthesize delegate;

- (id)init {
    if (self = [super init]) {
        // Fix me! Change to specific Feature Extractor
        classifier = [[GMGestureClassifier alloc] initWithFeatureExtractor:[[GMNormedGridExtractor alloc] init]];
        recorder = [[GMGestureRecorder alloc] init];
        recorder.delegate = self;
    }
    return self;
}

- (void)deleteTrainingSet:(NSString *)name {
    if ([classifier deleteTrainingSet:name]) {
        [delegate trainingSetDeleted:name];
    }
}

- (void)pushToGesture {
    [recorder pushToGesture:YES];
}

- (void)startClassificationMode:(NSString *)trainingSetName {
    activeTrainingSet = trainingSetName;
    isClassifying = YES;
    [recorder setRecordMode:MOTION_DETECTION];
    [recorder start];
    [classifier loadTrainingSet:trainingSetName];
}

- (void)startLearnMode:(NSString *)trainingSetName forGesture:(NSString *)gestureName {
    activeTrainingSet = trainingSetName;
    activeLearnLabel = gestureName;
    isLearning = YES;
    [recorder setRecordMode:PUSH_TO_GESTURE];
    [recorder pushToGesture:YES];
    [recorder start];
}

- (void)stopLearnMode {
    [recorder pushToGesture:NO];
    [recorder setRecordMode:MOTION_DETECTION];
    [recorder stop];
    isLearning = NO;
}

- (NSArray *)getGestureList:(NSString *)trainingSetName {
    return [classifier getLabels:trainingSetName];
}

- (void)stopClassificationMode {
    isClassifying = NO;
    [recorder stop];
}

- (void)deleteGestureInSet:(NSString *)trainingSetName withName:(NSString *)gestureName {
    [classifier deleteLabel:gestureName inTrainingSet:trainingSetName];
    [classifier commitData];
}

- (BOOL)isLearning {
    return isLearning;
}

- (BOOL)isClassifying {
    return isClassifying;
}

- (void)setThreshold:(float)threshold {
    [recorder setThreshold:threshold];
}

- (void)gestureRecorded:(NSArray *)values {
    if (isLearning) {
        [classifier trainData:[[GMGesture alloc] initWithValues:values andLabel:activeLearnLabel] inTrainingSet:activeTrainingSet];
        [classifier commitData];
        [delegate gestureLearned:activeLearnLabel];
        NSLog(@"Trained");
    } else if (isClassifying) {
        [recorder pause:YES];
        GMDistribution *distribution = [classifier classifySignalInTrainingSet:activeTrainingSet withGesture:[[GMGesture alloc] initWithValues:values andLabel:nil]];
        [recorder pause:NO];
        if (distribution != nil && [distribution size] > 0) {
            [delegate gestureRecognized:distribution];
        }
    }
}

@end
