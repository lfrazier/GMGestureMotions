//
//  GMGesture.h
//  GMGestureMotions
//
//  Created by Lauren Frazier on 1/25/13.
//  Copyright (c) 2017 Lauren Frazier. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GMGesture : NSObject {
    NSString *label;
    NSArray *values;
}

@property (nonatomic, retain) NSString *label;
@property (nonatomic, retain) NSArray *values;

- (id)initWithValues:(NSArray *)vals andLabel:(NSString *)labelString;
- (void)setValueAtIndex:(int)index dimension:(int)dim value:(float)val;
- (float)getValueAtIndex:(int)index dimension:(int)dim;
- (int)length;

@end
