//
//  GMFirstViewController.m
//  iOSGestureMotions
//
//  Created by Lauren Frazier on 1/25/13.
//  Copyright (c) 2013 Lauren Frazier. All rights reserved.
//

#import "GMRecordViewController.h"

@interface GMRecordViewController ()

@end

@implementation GMRecordViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    gestureRecognizer = ((GMAppDelegate *)[[UIApplication sharedApplication] delegate]).gestureRecognition;
}

- (void)viewDidAppear:(BOOL)animated {
    gestureRecognizer.delegate = self;
}


- (IBAction)buttonPressed:(UIButton *)sender {
    if ([[trainingSetTextField text] isEqualToString:@""] || [[gestureTextField text] isEqualToString:@""]) {
        [[[UIAlertView alloc] initWithTitle:@"Cannot Leave Blank" message:@"Oops! Looks like you left a field blank. Fill it in!" delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil] show];
        return;
    }
    
    if ([gestureRecognizer isLearning]) {
        [gestureRecognizer stopLearnMode];
        [sender setTitle:@"Record" forState:UIControlStateNormal];
    } else {
        [gestureRecognizer startLearnMode:[trainingSetTextField text] forGesture:[gestureTextField text]];
        [sender setTitle:@"Stop" forState:UIControlStateNormal];
    }
}


- (void)trainingSetDeleted:(NSString *)trainingSetName {
    
}

- (void)gestureLearned:(NSString *)gestureName {
    NSLog(gestureName);
}


- (void)gestureRecognized:(GMDistribution *)distribution {
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
