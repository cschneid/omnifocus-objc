//
//  Task.h
//  omnifocus
//
//  Created by Christopher Schneider on 2/11/12.
//  Copyright 2012 Personal. All rights reserved.
//
#ifndef omnifocus_task_h
#define omnifocus_task_h

#include "main.h"
@class BridgeComponentFinder;

@interface Task : NSObject
+ (void) createTaskFromEncodedString: (NSString*) taskString;
+ (NSDictionary*) parseTaskString: (NSString*) taskString usingBridge: (BridgeComponentFinder*) bridge;
@end

#endif
