//
//  GMGestureRecorder.h
//  iOSGestureMotions
//
//  Created by Lauren Frazier on 1/25/13.
//  Copyright (c) 2013 Lauren Frazier. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreMotion/CoreMotion.h>

typedef enum RecordMode {
    MOTION_DETECTION = 0,
    PUSH_TO_GESTURE = 1
} RecordMode;

@protocol GMGestureRecorderDelegate <NSObject>

- (void)gestureRecorded:(NSArray *)values;

@end

@interface GMGestureRecorder : NSObject {
    int MIN_GESTURE_SIZE;
    float THRESHOLD;
    BOOL isRecording;
    int stepsSinceNoMovement;
    NSMutableArray *gestureValues;
    CMMotionManager *motionManager;
    BOOL isRunning;
    RecordMode recordMode;
    float deviceUpdateInterval;
    int noMotionLimit;
}

@property (nonatomic, retain) id<GMGestureRecorderDelegate> delegate;

- (RecordMode)getRecordMode;
- (void)setRecordMode:(RecordMode)recMode;
- (void)setThreshold:(float)threshold;
- (BOOL)isRunning;
- (void)pushToGesture:(BOOL)pushed;
//- (void)handleDeviceUpdate:(CMDeviceMotion *)motion;
- (void)start;
- (void)stop;
- (void)pause:(BOOL)b;

@end
