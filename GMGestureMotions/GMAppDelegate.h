//
//  GMAppDelegate.h
//  GMGestureMotions
//
//  Created by Lauren Frazier on 1/25/13.
//  Copyright (c) 2013 Lauren Frazier. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GMGestureRecognition.h"

@interface GMAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) GMGestureRecognition *gestureRecognition;

@end
