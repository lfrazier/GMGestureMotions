//
//  GMGestureRecognition.m
//  GMGestureMotions
//
//  Created by Lauren Frazier on 1/25/13.
//  Copyright (c) 2017 Lauren Frazier. All rights reserved.
//

#import "GMGestureRecognition.h"

@interface GMGestureRecognition ()<GMGestureRecorderDelegate> {
  BOOL _isLearning;
  BOOL _isClassifying;
  GMGestureClassifier *_classifier;
  GMGestureRecorder *_recorder;
  NSString *_activeTrainingSet;
  NSString *_activeLearnLabel;
}

@end

@implementation GMGestureRecognition

+ (GMGestureRecognition *)sharedInstance {
  static GMGestureRecognition *_sharedInstance = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    _sharedInstance = [[GMGestureRecognition alloc] init];
  });
  return _sharedInstance;
}

- (id)init {
  if (self = [super init]) {
    // Fix me! Change to specific Feature Extractor
    GMNormedGridExtractor *featureExtractor = [[GMNormedGridExtractor alloc] init];
    _classifier = [[GMGestureClassifier alloc] initWithFeatureExtractor:featureExtractor];
    _recorder = [[GMGestureRecorder alloc] init];
    _recorder.delegate = self;
  }
  return self;
}

#pragma mark - Public

- (void)startLearnMode:(NSString *)trainingSetName forGesture:(NSString *)gestureName {
  _activeTrainingSet = trainingSetName;
  _activeLearnLabel = gestureName;
  _isLearning = YES;
  [_recorder setRecordMode:GMGestureRecordModePushToGesture];
  [_recorder pushToGesture:YES];
  [_recorder start];
}

- (void)stopLearnMode {
  [_recorder pushToGesture:NO];
  [_recorder setRecordMode:GMGestureRecordModeMotionDetection];
  [_recorder stop];
  _isLearning = NO;
}

- (NSArray<NSString *> *)getGestureListForTrainingSet:(NSString *)trainingSet {
  return [_classifier getLabels:trainingSet];
}

- (void)startClassificationModeWithTrainingSet:(NSString *)trainingSet {
  _activeTrainingSet = trainingSet;
  _isClassifying = YES;
  [_recorder setRecordMode:GMGestureRecordModeMotionDetection];
  [_recorder start];
  [_classifier loadTrainingSet:trainingSet];
}

- (void)stopClassificationMode {
  _isClassifying = NO;
  [_recorder stop];
}

- (void)deleteGesture:(NSString *)gestureName fromTrainingSet:(NSString *)trainingSetName {
  [_classifier deleteLabel:gestureName inTrainingSet:trainingSetName];
  [_classifier commitData];
}

- (void)deleteTrainingSet:(NSString *)name {
  if ([_classifier deleteTrainingSet:name]) {
    [self.delegate trainingSetDeleted:name];
  }
}

- (BOOL)isLearning {
  return _isLearning;
}

- (BOOL)isClassifying {
  return _isClassifying;
}

- (void)setThreshold:(float)threshold {
  [_recorder setThreshold:threshold];
}

#pragma mark - Protocols

#pragma mark GMGestureRecorderDelegate

- (void)gestureRecorded:(NSArray *)values {
  if (_isLearning) {
    [_classifier trainData:[[GMGesture alloc] initWithValues:values andLabel:_activeLearnLabel] inTrainingSet:_activeTrainingSet];
    [_classifier commitData];
    [self.delegate gestureLearned:_activeLearnLabel];
    NSLog(@"Trained");
  } else if (_isClassifying) {
    [_recorder pause:YES];
    GMDistribution *distribution = [_classifier classifySignalInTrainingSet:_activeTrainingSet withGesture:[[GMGesture alloc] initWithValues:values andLabel:nil]];
    [_recorder pause:NO];
    if (distribution != nil && [distribution size] > 0) {
      [self.delegate gestureRecognized:distribution];
    }
  }
}

@end
