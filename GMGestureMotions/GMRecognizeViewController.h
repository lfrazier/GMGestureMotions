//
//  GMSecondViewController.h
//  GMGestureMotions
//
//  Created by Lauren Frazier on 1/25/13.
//  Copyright (c) 2017 Lauren Frazier. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GMAppDelegate.h"

@interface GMRecognizeViewController : UIViewController <GMGestureRecognitonDelegate> {
    GMGestureRecognition *gestureRecognizer;
    IBOutlet UILabel *label;
    IBOutlet UILabel *infoLabel;
}

@end
