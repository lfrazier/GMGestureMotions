//
//  GMGestureClassifier.m
//  GMGestureMotions
//
//  Created by Lauren Frazier on 1/25/13.
//  Copyright (c) 2017 Lauren Frazier. All rights reserved.
//

#import "GMGestureClassifier.h"

@interface GMGestureClassifier ()  {
  NSMutableArray *_trainingSet;
  NSString *_activeTrainingSet;
}

@end

@implementation GMGestureClassifier

- (id)initWithFeatureExtractor:(GMFeatureExtractor *)featureExtractor {
  if ( self = [super init] ) {
    _trainingSet = [NSMutableArray array];
    _featureExtractor = featureExtractor;
  }
  return self;
}

- (BOOL)commitData {
  if (_activeTrainingSet != nil && ![_activeTrainingSet isEqualToString:@""]) {
    // Write to plist from trainingSet
    NSString *rootPath =
        NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *plistPath = [rootPath stringByAppendingPathComponent:
        [NSString stringWithFormat:@"%@.plist", _activeTrainingSet]];
    NSArray *temp = [NSArray arrayWithArray:_trainingSet];
    [temp writeToFile:plistPath atomically:YES];
    return YES;
  } else {
    return NO;
  }
}

- (BOOL)trainData:(GMGesture *)signal inTrainingSet:(NSString *)trainingSetName {
  [self loadTrainingSet:trainingSetName];
  [_trainingSet addObject:[self.featureExtractor sampleSignal:signal]];
  return YES;
}

- (void)loadTrainingSet:(NSString *)trainingSetName {
  if (![trainingSetName isEqualToString:_activeTrainingSet]) {
    _activeTrainingSet = trainingSetName;
    // Load info from plist into trainingSet.
    NSError *error;
    NSString *plistPath;
    NSString *rootPath =
        NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    plistPath = [rootPath stringByAppendingPathComponent:
        [NSString stringWithFormat:@"%@.plist", _activeTrainingSet]];
    if ([[NSFileManager defaultManager] fileExistsAtPath:plistPath]) {
      NSData *plistXML = [[NSFileManager defaultManager] contentsAtPath:plistPath];
      NSMutableArray *temp =
          (NSMutableArray *)[NSPropertyListSerialization
              propertyListWithData:plistXML
                           options:NSPropertyListMutableContainersAndLeaves
                            format:nil
                             error:&error];
      if (!temp) {
        NSLog(@"Error reading plist: %@", error);
      } else {
        _trainingSet = temp;
      }
    }
  }
}

- (BOOL)checkForLabel:(NSString *)label inTrainingSet:(NSString *)trainingSetName {
  [self loadTrainingSet:trainingSetName];
  for (GMGesture *s in _trainingSet) {
    if ([s.label isEqualToString:label]) {
      return YES;
    }
  }
  return NO;
}

- (BOOL)checkForTrainingSet:(NSString *)trainingSetName {
  NSString *rootPath =
      NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
  NSString *plistPath = [rootPath stringByAppendingPathComponent:
      [NSString stringWithFormat:@"%@.plist", trainingSetName]];
  return [[NSFileManager defaultManager] fileExistsAtPath:plistPath];
}

- (BOOL)deleteTrainingSet:(NSString *)trainingSetName {
  if (_activeTrainingSet != nil && [_activeTrainingSet isEqualToString:trainingSetName]) {
    _trainingSet = [NSMutableArray array];
  }
  NSError *error;
  NSString *rootPath =
      NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
  NSString *plistPath = [rootPath stringByAppendingPathComponent:
      [NSString stringWithFormat:@"%@.plist", trainingSetName]];
  if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath]) {
    plistPath = [[NSBundle mainBundle] pathForResource:_activeTrainingSet ofType:@"plist"];
  }
  [[NSFileManager defaultManager] removeItemAtPath:plistPath error:&error];
  return YES;
}

- (BOOL)deleteLabel:(NSString *)labelName inTrainingSet:(NSString *)trainingSetName {
  [self loadTrainingSet:trainingSetName];
  BOOL labelExisted = NO;
  GMGesture *toDelete;
  for (GMGesture *s in _trainingSet) {
    if ([s.label isEqualToString:labelName]) {
      toDelete = s;
      labelExisted = YES;
      break;
    }
  }
  if (toDelete != nil) {
    [_trainingSet removeObject:toDelete];
  }
  return labelExisted;
}

- (NSArray<NSString *> *)getLabels:(NSString *)trainingSetName {
  [self loadTrainingSet:trainingSetName];
  NSMutableArray *labels = [NSMutableArray array];
  for (GMGesture *s in _trainingSet) {
    if (![labels containsObject:s.label]) {
      [labels addObject:s.label];
    }
  }
  return labels;
}

- (GMDistribution *)classifySignalInTrainingSet:(NSString *)trainingSetName
                                    withGesture:(GMGesture *)signal {
  if (trainingSetName == nil) {
    NSLog(@"No Training Set Name specified");
  }
  if (![trainingSetName isEqualToString:_activeTrainingSet]) {
    [self loadTrainingSet:trainingSetName];
  }

  if ([_trainingSet count] == 0) {
    NSLog(@"No training data for training set %@", trainingSetName);
  }

  GMDistribution *distribution = [[GMDistribution alloc] init];
  GMGesture *sampledSignal = [_featureExtractor sampleSignal:signal];

  for (GMGesture *gesture in _trainingSet) {
    double dist = [DTWAlgorithm calcDistanceBetweenGesture:gesture andGesture:sampledSignal];
    [distribution addEntryWithTag:gesture.label distance:dist];
  }

  return distribution;
}


@end
