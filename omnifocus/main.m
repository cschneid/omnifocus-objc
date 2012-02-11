//
//  main.m
//  omnifocus
//
//  Created by Christopher Schneider on 2/11/12.
//  Copyright 2012 Personal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ScriptingBridge/ScriptingBridge.h>
#import "Omnifocus.h"

int main (int argc, const char * argv[])
{

    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];

    NSString *name;
    if (argc > 0) {
        name = [NSString stringWithCString:argv[1]];
    } else {
        name = @"from obj-c when there wasn't an arg";
    }
        
    
    omnifocusApplication *omnifocus = [SBApplication applicationWithBundleIdentifier:@"com.omnigroup.OmniFocus"];
    
    [omnifocus classForScriptingClass:@"task"];
    
    omnifocusDocument *document = [omnifocus defaultDocument];
    
    NSDictionary *taskprops = [[NSDictionary alloc] initWithObjectsAndKeys:name, @"name", nil];
                 
    omnifocusTask *task = [[[[omnifocus classForScriptingClass:@"task"] alloc] initWithProperties:taskprops] autorelease];
    
    [[document inboxTasks] addObject:task];
    
    
    [pool drain];
    return 0;
}

