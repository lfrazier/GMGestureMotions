//
//  GMGestureRecorder.h
//  GMGestureMotions
//
//  Created by Lauren Frazier on 1/25/13.
//  Copyright (c) 2017 Lauren Frazier. All rights reserved.
//

@import CoreMotion;
@import Foundation;

/// The two types of recording. GMGestureRecordModeMotionDetection is to classify the gesture,
/// GMGestureRecordModePushToGesture is to add to a gesture we are learning.
typedef NS_ENUM(NSUInteger, GMGestureRecordMode) {
  GMGestureRecordModeMotionDetection,
  GMGestureRecordModePushToGesture
};

/// Handles the completion of a gesture recording.
@protocol GMGestureRecorderDelegate <NSObject>

/// Called when a gesture has been successfully recognized.
- (void)gestureRecorded:(NSArray *)values;

@end

/// Records gestures that are being performed by the user. The recorded gesture could be stored,
/// classified, etc.
@interface GMGestureRecorder : NSObject

@property (nonatomic, weak) id<GMGestureRecorderDelegate> delegate;

/// The record mode that the recorder is in. It is either classifying gestures or learning them.
@property(nonatomic) GMGestureRecordMode recordMode;

/// True if the recorder is running at the moment.
@property(nonatomic) BOOL isRunning;

/// Sets the threshold that the recorder should use to consider a movement a gesture motion.
- (void)setThreshold:(float)threshold;

/// Pushes ...?
- (void)pushToGesture:(BOOL)pushed;

/// Starts the recorder.
- (void)start;

/// Stops the recorder.
- (void)stop;

/// Pauses or unpauses the recorder. If \a pause is true, pauses, otherwise unpauses.
- (void)pause:(BOOL)pause;

@end
