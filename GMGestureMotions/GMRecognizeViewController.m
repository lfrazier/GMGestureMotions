//
//  GMSecondViewController.m
//  GMGestureMotions
//
//  Created by Lauren Frazier on 1/25/13.
//  Copyright (c) 2017 Lauren Frazier. All rights reserved.
//

#import "GMRecognizeViewController.h"

@interface GMRecognizeViewController ()

@end

@implementation GMRecognizeViewController

#define MAX_DISTANCE 100.0

- (void)viewDidLoad {
  [super viewDidLoad];
  gestureRecognizer = [GMGestureRecognition sharedInstance];
}

- (void)viewDidAppear:(BOOL)animated {
  gestureRecognizer.delegate = self;
  [gestureRecognizer startClassificationModeWithTrainingSet:@"Default"];
  NSString *infoString = @"Gestures:";
  for (NSString *string in [gestureRecognizer getGestureListForTrainingSet:@"Default"]) {
    infoString = [NSString stringWithFormat:@"%@\n%@", infoString, string];
  }
  [infoLabel setText:infoString];
}

- (void)viewDidDisappear:(BOOL)animated {
  [gestureRecognizer stopClassificationMode];
  gestureRecognizer.delegate = nil;
}

- (void)trainingSetDeleted:(NSString *)trainingSetName {

}

- (void)gestureLearned:(NSString *)gestureName {
  NSLog(@"%@", gestureName);
}


- (void)gestureRecognized:(GMDistribution *)distribution {
  NSLog(@"%@: %f",[distribution getBestMatch], [distribution getBestDistance]);
  if ([distribution getBestDistance] < MAX_DISTANCE) {
    [label setText:[NSString stringWithFormat:@"%@:\n%f",[distribution getBestMatch],
        [distribution getBestDistance]]];
  }
}

@end
