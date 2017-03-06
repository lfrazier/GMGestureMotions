//
//  GMClassifyViewController.m
//  GMGestureMotions
//
//  Created by Lauren on 2/27/17.
//  Copyright © 2017 Lauren Frazier. All rights reserved.
//

#import "GMClassifyViewController.h"

#import "GMGestureRecognition.h"

@interface GMClassifyViewController ()<GMGestureRecognitonDelegate>

@property(nonatomic, strong) IBOutlet UITextView *textView;

@end

@implementation GMClassifyViewController

static NSString *const kDefaultTrainingSet = @"kDefaultTrainingSet";

- (void)viewDidLoad {
  [super viewDidLoad];
  [[GMGestureRecognition sharedInstance] setThreshold:3];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [GMGestureRecognition sharedInstance].delegate = self;
  [[GMGestureRecognition sharedInstance]
      startClassificationModeWithTrainingSet:kDefaultTrainingSet];
}

- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];
  [[GMGestureRecognition sharedInstance] stopClassificationMode];
}

#pragma mark - Protocols

#pragma mark GMGestureRecognitionDelegate

- (void)gestureRecognized:(GMDistribution *)distribution {
  NSString *infoString = [NSString stringWithFormat:@"%@, Distance: %f",
                             [distribution bestMatch], [distribution bestDistance]];
  NSMutableString *gestureList = [NSMutableString stringWithString:self.textView.text];
  [gestureList appendFormat:@"\n%@", infoString];
  _textView.text = [NSString stringWithString:gestureList];
}

@end
