//
//  GMGestureClassifier.m
//  GMGestureMotions
//
//  Created by Lauren Frazier on 1/25/13.
//  Copyright (c) 2013 Lauren Frazier. All rights reserved.
//

#import "GMGestureClassifier.h"

@implementation GMGestureClassifier

@synthesize featureExtractor;

- (id)initWithFeatureExtractor:(GMFeatureExtractor *)fE {
    if ( self = [super init] ) {
        trainingSet = [NSMutableArray array];
        featureExtractor = fE;
    }
    return self;
}

- (BOOL)commitData {
    if (activeTrainingSet != nil && ![activeTrainingSet isEqualToString:@""]) {
        // Write to plist from trainingSet
        NSString *error;
        NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString *plistPath = [rootPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist", activeTrainingSet]];
        NSArray *temp = [NSArray arrayWithArray:trainingSet];
        [temp writeToFile:plistPath atomically:YES];
        /*NSData *plistData = [NSPropertyListSerialization dataFromPropertyList:temp format:NSPropertyListXMLFormat_v1_0 errorDescription:&error];
        if(plistData) {
            [plistData writeToFile:plistPath atomically:YES];
        }
        else {
            NSLog(@"Error : %@",error);
        }
         */
        return YES;
    } else {
        return NO;
    }
}

- (BOOL)trainData:(GMGesture *)signal inTrainingSet:(NSString *)trainingSetName {
    [self loadTrainingSet:trainingSetName];
    [trainingSet addObject:[featureExtractor sampleSignal:signal]];
    return YES;
}

- (void)loadTrainingSet:(NSString *)trainingSetName {
    if (![trainingSetName isEqualToString:activeTrainingSet]) {
        activeTrainingSet = trainingSetName;
        // Load info from plist into trainingSet.
        NSError *error;
        NSString *plistPath;
        NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        plistPath = [rootPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist", activeTrainingSet]];
        if ([[NSFileManager defaultManager] fileExistsAtPath:plistPath]) {
            NSData *plistXML = [[NSFileManager defaultManager] contentsAtPath:plistPath];
            NSMutableArray *temp = (NSMutableArray *)[NSPropertyListSerialization
                                                      propertyListWithData:plistXML options:NSPropertyListMutableContainersAndLeaves format:nil error:&error];
            if (!temp) {
                NSLog(@"Error reading plist: %@", error);
            } else {
                trainingSet = temp;
            }
        }
    }
}

- (BOOL)checkForLabel:(NSString *)label inTrainingSet:(NSString *)trainingSetName {
    [self loadTrainingSet:trainingSetName];
    for (GMGesture *s in trainingSet) {
        if ([s.label isEqualToString:label]) {
            return YES;
        }
    }
    return NO;
}

- (BOOL)checkForTrainingSet:(NSString *)trainingSetName {
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *plistPath = [rootPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist", trainingSetName]];
    return [[NSFileManager defaultManager] fileExistsAtPath:plistPath];
}

- (BOOL)deleteTrainingSet:(NSString *)trainingSetName {
    if (activeTrainingSet != nil && [activeTrainingSet isEqualToString:trainingSetName]) {
        trainingSet = [NSMutableArray array];
    }
    NSError *error;
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *plistPath = [rootPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist", trainingSetName]];
    if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath]) {
        plistPath = [[NSBundle mainBundle] pathForResource:activeTrainingSet ofType:@"plist"];
    }
    [[NSFileManager defaultManager] removeItemAtPath:plistPath error:&error];
    return YES;
}

- (BOOL)deleteLabel:(NSString *)labelName inTrainingSet:(NSString *)trainingSetName {
    [self loadTrainingSet:trainingSetName];
    BOOL labelExisted = NO;
    GMGesture *toDelete;
    for (GMGesture *s in trainingSet) {
        if ([s.label isEqualToString:labelName]) {
            toDelete = s;
            labelExisted = YES;
            break;
        }
    }
    if (toDelete != nil) {
        [trainingSet removeObject:toDelete];
    }
    return labelExisted;
}

- (NSArray<NSString *> *)getLabels:(NSString *)trainingSetName {
    [self loadTrainingSet:trainingSetName];
    NSMutableArray *labels = [NSMutableArray array];
    for (GMGesture *s in trainingSet) {
        if (![labels containsObject:s.label]) {
            [labels addObject:s.label];
        }
    }
    return labels;
}

- (GMDistribution *)classifySignalInTrainingSet:(NSString *)trainingSetName withGesture:(GMGesture *)signal {
    if (trainingSetName == nil) {
        NSLog(@"No Training Set Name specified");
    }
    if (![trainingSetName isEqualToString:activeTrainingSet]) {
        [self loadTrainingSet:trainingSetName];
    }
    
    if ([trainingSet count] == 0) {
        NSLog(@"No training data for training set %@", trainingSetName);
    }
    
    GMDistribution *distribution = [[GMDistribution alloc] init];
    GMGesture *sampledSignal = [featureExtractor sampleSignal:signal];
    
    for (GMGesture *s in trainingSet) {
        double dist = [DTWAlgorithm calcDistanceBetweenGesture:s andGesture:sampledSignal];
        [distribution addEntryWithTag:s.label distance:dist];
    }

    return distribution;
}


@end
