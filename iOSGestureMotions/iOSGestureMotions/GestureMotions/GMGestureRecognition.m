//
//  GMGestureRecognition.m
//  iOSGestureMotions
//
//  Created by Lauren Frazier on 1/25/13.
//  Copyright (c) 2013 Lauren Frazier. All rights reserved.
//

#import "GMGestureRecognition.h"

@implementation GMGestureRecognition

- (id)init {
    if (self = [super init]) {
        
    }
    return self;
}

- (void)startClassificationMode:(NSString *)trainingSetName {
    activeTrainingSet = trainingSetName;
    isClassifying = YES;
}

@end
