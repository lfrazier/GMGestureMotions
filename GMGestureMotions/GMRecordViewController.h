//
//  GMFirstViewController.h
//  GMGestureMotions
//
//  Created by Lauren Frazier on 1/25/13.
//  Copyright (c) 2013 Lauren Frazier. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GMAppDelegate.h"

@interface GMRecordViewController : UIViewController <GMGestureRecognitonDelegate, UITextFieldDelegate> {
    IBOutlet UITextField *trainingSetTextField;
    IBOutlet UITextField *gestureTextField;
    
    GMGestureRecognition *gestureRecognizer;
}

- (IBAction)buttonPressed:(UIButton *)sender;

@end
