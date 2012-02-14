//
//  main.h
//  omnifocus
//
//  Created by Christopher Schneider on 2/11/12.
//  Copyright 2012 Personal. All rights reserved.
//

#ifndef omnifocus_main_h
#define omnifocus_main_h

#import <Foundation/Foundation.h>
#import <ScriptingBridge/ScriptingBridge.h>
#import "Omnifocus.h"
#import "BridgeComponentFinder.h"
#import "Task.h"

void parse_args(int argc, char * const argv[]);
void usage();

#endif
