iOSGestureMotions
=================

iOS port of Robert Neßelrath's Android Gesture Recognition Tool/Framework (available at http://www.dfki.de/~rnessel/tools/gesture_recognition/gesture_recognition.htm)

Usage:

1. Copy the GestureMotions folder into your project.

2. Import "GMGestureRecognition.h"

3. Create a GMGestureRecognition object.
Note: This object is meant to be a singleton, to prevent the iPhone gyroscope from slowing down/scrambling data.

4. Implement the GMGestureRecognitionDelegate protocol in any class that will send/recieve feedback from the gesture recognizer.

GMGestureRecognition provides the following methods:

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

Please see the demo app for more details. The demo app allows users to name and define gestures in one tab, then perform them in the other tab. The closest match is printed out on the screen, along with the distance to that gesture.
