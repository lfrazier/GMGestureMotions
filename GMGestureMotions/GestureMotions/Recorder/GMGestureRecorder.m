//
//  GMGestureRecorder.m
//  GMGestureMotions
//
//  Created by Lauren Frazier on 1/25/13.
//  Copyright (c) 2017 Lauren Frazier. All rights reserved.
//

#import "GMGestureRecorder.h"

@interface GMGestureRecorder ()  {
  BOOL _isRecording;
  int _stepsSinceNoMovement;
  NSMutableArray *_gestureValues;
  CMMotionManager *_motionManager;
}

@end

@implementation GMGestureRecorder

static float kThreshold;
static int kMinGestureSize;
static float kDeviceUpdateInterval;
static int kNoMotionLimit;

- (id)init {
  if (self = [super init]) {
    kMinGestureSize = 4;
    kThreshold = 2;
    _recordMode = GMGestureRecordModeMotionDetection;
    kDeviceUpdateInterval = 0.01;
    kNoMotionLimit = 20;
  }
  return self;
}

- (float)calcVectorNorm:(NSArray *)values {
  int X = 0;
  int Y = 1;
  int Z = 2;
  float norm = sqrtf(([values[X] doubleValue] * [values[X] doubleValue]) +
                     ([values[Y] doubleValue] * [values[Y] doubleValue]) +
                     ([values[Z] doubleValue] * [values[Z] doubleValue]));
  return norm;
}

- (void)setThreshold:(float)threshold {
  kThreshold = threshold;
  NSLog(@"New Threshold = %f", threshold);
}

- (void)pushToGesture:(BOOL)pushed {
  if (_recordMode == GMGestureRecordModePushToGesture) {
    _isRecording = pushed;
    if (_isRecording) {
      _gestureValues = [NSMutableArray array];
    } else {
      if ([_gestureValues count] > kMinGestureSize) {
        [self.delegate gestureRecorded:_gestureValues];
      }
      _gestureValues = nil;
    }
  }
}

- (void)handleDeviceUpdate:(CMAccelerometerData *)motion {
  NSLog(@"X: %f, Y: %f, Z:%f", motion.acceleration.x, motion.acceleration.y, motion.acceleration.z);
  NSArray *value = @[@(motion.acceleration.x), @(motion.acceleration.y), @(motion.acceleration.z)];
  switch (_recordMode) {
    case GMGestureRecordModeMotionDetection:
      if (_isRecording) {
        [_gestureValues addObject:value];
        if ([self calcVectorNorm:value] < kThreshold) {
          _stepsSinceNoMovement++;
        } else {
          _stepsSinceNoMovement = 0;
        }
      } else if ([self calcVectorNorm:value] >= kThreshold) {
        _isRecording = YES;
        _stepsSinceNoMovement = 0;
        _gestureValues = [NSMutableArray arrayWithObject:value];
      }
      if (_stepsSinceNoMovement == kNoMotionLimit) {
        NSLog(@"Length: %lu", [_gestureValues count] - kNoMotionLimit);
        if (([_gestureValues count] - kNoMotionLimit) > kMinGestureSize) {
          NSRange range;
          range.location = 0;
          range.length = [_gestureValues count] - kNoMotionLimit;
          [self.delegate gestureRecorded:[_gestureValues subarrayWithRange:range]];
        }
        _gestureValues = nil;
        _stepsSinceNoMovement = 0;
        _isRecording = NO;
      }
      break;
    case GMGestureRecordModePushToGesture:
      if (_isRecording) {
        [_gestureValues addObject:value];
      }
      break;

    default:
      break;
  }
}

- (void)start {
  _motionManager = [[CMMotionManager alloc] init];
  if ([_motionManager isAccelerometerAvailable]) {
    if (![_motionManager isAccelerometerActive]) {
      [_motionManager setAccelerometerUpdateInterval:kDeviceUpdateInterval];
      [_motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMAccelerometerData *motion, NSError *error) {
        [self handleDeviceUpdate:motion];
      }];
    }
  }
}

- (void)stop {
  [_motionManager stopGyroUpdates];
  _isRunning = NO;
}

- (void)pause:(BOOL)pause {
  if (pause) {
    [_motionManager stopAccelerometerUpdates];
  } else {
    [_motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMAccelerometerData *motion, NSError *error) {
      [self handleDeviceUpdate:motion];
    }];    }
}

@end
