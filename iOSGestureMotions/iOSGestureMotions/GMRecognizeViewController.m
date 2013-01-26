//
//  GMSecondViewController.m
//  iOSGestureMotions
//
//  Created by Lauren Frazier on 1/25/13.
//  Copyright (c) 2013 Lauren Frazier. All rights reserved.
//

#import "GMRecognizeViewController.h"

@interface GMRecognizeViewController ()

@end

@implementation GMRecognizeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    gestureRecognizer = ((GMAppDelegate *)[[UIApplication sharedApplication] delegate]).gestureRecognition;
}

- (void)viewDidAppear:(BOOL)animated {
    gestureRecognizer.delegate = self;
    [gestureRecognizer startClassificationMode:@"Default"];
    NSString *infoString = @"Gestures:";
    for (NSString *string in [gestureRecognizer getGestureList:@"Default"]) {
        infoString = [NSString stringWithFormat:@"%@\n%@", infoString, string];
    }
    [infoLabel setText:infoString];
}


- (void)trainingSetDeleted:(NSString *)trainingSetName {
    
}

- (void)gestureLearned:(NSString *)gestureName {
    NSLog(gestureName);
}


- (void)gestureRecognized:(GMDistribution *)distribution {
    NSLog(@"%@: %f",[distribution getBestMatch], [distribution getBestDistance]);
    [label setText:[NSString stringWithFormat:@"%@:\n%f",[distribution getBestMatch], [distribution getBestDistance]]];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
