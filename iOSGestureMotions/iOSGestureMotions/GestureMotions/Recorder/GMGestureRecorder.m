//
//  GMGestureRecorder.m
//  iOSGestureMotions
//
//  Created by Lauren Frazier on 1/25/13.
//  Copyright (c) 2013 Lauren Frazier. All rights reserved.
//

#import "GMGestureRecorder.h"

@implementation GMGestureRecorder

@synthesize delegate;

- (id)init {
    if (self = [super init]) {
        MIN_GESTURE_SIZE = 8;
        THRESHOLD = 2;
        recordMode = MOTION_DETECTION;
        deviceUpdateInterval = 0.05;
        noMotionLimit = 10;
    }
    return self;
}

- (float)calcVectorNorm:(NSArray *)values {
    int X = 0;
    int Y = 1;
    int Z = 2;
    float norm = sqrtf(([values[X] doubleValue] * [values[X] doubleValue]) + ([values[Y] doubleValue] * [values[Y] doubleValue]) + ([values[Z] doubleValue] * [values[Z] doubleValue]));
    return norm;
}

- (RecordMode)getRecordMode {
    return recordMode;
}

- (void)setRecordMode:(RecordMode)recMode {
    recordMode = recMode;
}

- (void)setThreshold:(float)threshold {
    THRESHOLD = threshold;
    NSLog(@"New Threshold = %f", threshold);
}

- (BOOL)isRunning {
    return isRunning;
}

- (void)pushToGesture:(BOOL)pushed {
    if (recordMode == PUSH_TO_GESTURE) {
        isRecording = pushed;
        if (isRecording) {
            gestureValues = [NSMutableArray array];
        } else {
            if ([gestureValues count] > MIN_GESTURE_SIZE) {
                [delegate gestureRecorded:gestureValues];
            }
            gestureValues = nil;
        }
    }
}

- (void)handleDeviceUpdate:(CMGyroData *)motion {
    //NSLog(@"X: %f, Y: %f, Z:%f", motion.rotationRate.x, motion.rotationRate.y, motion.rotationRate.z);
    NSArray *value = @[[NSNumber numberWithDouble:motion.rotationRate.x], [NSNumber numberWithDouble:motion.rotationRate.y], [NSNumber numberWithDouble:motion.rotationRate.z]];
    switch (recordMode) {
        case MOTION_DETECTION:
            if (isRecording) {
                [gestureValues addObject:value];
                if ([self calcVectorNorm:value] < THRESHOLD) {
                    stepsSinceNoMovement++;
                } else {
                    stepsSinceNoMovement = 0;
                }
            } else if ([self calcVectorNorm:value] >= THRESHOLD) {
                isRecording = YES;
                stepsSinceNoMovement = 0;
                gestureValues = [NSMutableArray arrayWithObject:value];
            }
            if (stepsSinceNoMovement == noMotionLimit) {
                NSLog(@"Length: %d", [gestureValues count] - noMotionLimit);
                if (([gestureValues count] - noMotionLimit) > MIN_GESTURE_SIZE) {
                    NSRange range;
                    range.location = 0;
                    range.length = [gestureValues count] - noMotionLimit;
                    [delegate gestureRecorded:[gestureValues subarrayWithRange:range]];
                }
                gestureValues = nil;
                stepsSinceNoMovement = 0;
                isRecording = NO;
            }
            break;
        case PUSH_TO_GESTURE:
            if (isRecording) {
                [gestureValues addObject:value];
            }
            break;
            
        default:
            break;
    }
}

- (void)start {
    motionManager = [[CMMotionManager alloc] init];
    if ([motionManager isGyroAvailable]) {
        if (![motionManager isGyroActive]) {
            [motionManager setGyroUpdateInterval:deviceUpdateInterval];
            [motionManager startGyroUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMGyroData *motion, NSError *error) {
                [self handleDeviceUpdate:motion];
            }];
        }
    }
}

- (void)stop {
    [motionManager stopGyroUpdates];
    isRunning = NO;
}

- (void)pause:(BOOL)b {
    if (b) {
        [motionManager stopGyroUpdates];
    } else {
        [motionManager startGyroUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMGyroData *motion, NSError *error) {
            [self handleDeviceUpdate:motion];
        }];    }
}

@end
