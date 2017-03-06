//
//  GMLearnViewController.m
//  GMGestureMotions
//
//  Created by Lauren on 2/27/17.
//  Copyright © 2017 Lauren Frazier. All rights reserved.
//

#import "GMLearnViewController.h"

#import "GMGestureRecognition.h"

@interface GMLearnViewController ()<GMGestureRecognitonDelegate>

@property(nonatomic, strong) IBOutlet UITextField *nameTextField;
@property(nonatomic, strong) IBOutlet UIButton *recordButton;

@property(nonatomic) BOOL isRecording;

@end

@implementation GMLearnViewController

static NSString *const kDefaultTrainingSet = @"kDefaultTrainingSet";

- (void)viewDidLoad {
  [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [GMGestureRecognition sharedInstance].delegate = self;
}

#pragma mark - Protocols

#pragma mark GMGestureRecognitionDelegate

- (void)gestureLearned:(NSString *)gestureName {
  UIAlertController *alert =
  [UIAlertController alertControllerWithTitle:@"Success"
                                      message:[NSString
                                               stringWithFormat:@"Gesture recorded: %@",
                                               gestureName]
                               preferredStyle:UIAlertControllerStyleAlert];
  UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                     style:UIAlertActionStyleDefault
                                                   handler:nil];
  [alert addAction:okAction];
  [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - Private

- (void)startRecording {
  [self.nameTextField resignFirstResponder];
  if (self.nameTextField.text.length == 0) {
    UIAlertController *alert =
        [UIAlertController alertControllerWithTitle:@"Missing name"
                                            message:@"Please enter a gesture name"
                                     preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                       style:UIAlertActionStyleDefault
                                                     handler:nil];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];
    return;
  }

  _isRecording = !_isRecording;
  [self.recordButton setTitle:@"Stop" forState:UIControlStateNormal];
  [[GMGestureRecognition sharedInstance] startLearnModeForGesture:self.nameTextField.text
                                                            inSet:kDefaultTrainingSet];
}

- (void)stopRecording {
  _isRecording = !_isRecording;
  [self.recordButton setTitle:@"Record" forState:UIControlStateNormal];
  [[GMGestureRecognition sharedInstance] stopLearnMode];
}

#pragma mark IBActions

- (IBAction)recordButtonTapped:(id)sender {
  if (!_isRecording) {
    [self startRecording];
  } else {
    [self stopRecording];
  }
}

@end
