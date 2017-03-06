//
//  GMDistribution.m
//  GMGestureMotions
//
//  Created by Lauren Frazier on 1/25/13.
//  Copyright (c) 2017 Lauren Frazier. All rights reserved.
//

#import "GMDistribution.h"

@interface GMDistribution () {
  NSString *_best;
  double _minDistance;
  NSMutableDictionary *_distribution;
}

@end

@implementation GMDistribution

- (id)init {
  if (self = [super init]) {
    _distribution = [NSMutableDictionary dictionary];
    _minDistance = DBL_MAX;
  }
  return self;
}

- (void)addEntryWithTag:(NSString *)tag distance:(double)distance {
  _distribution[tag] = @(distance);
  if (distance < _minDistance) {
    _minDistance = distance;
    _best = tag;
  }
}

- (NSString *)bestMatch {
  return _best;
}

- (double)bestDistance {
  return _minDistance;
}

- (NSUInteger)size {
  return [_distribution count];
}

@end
