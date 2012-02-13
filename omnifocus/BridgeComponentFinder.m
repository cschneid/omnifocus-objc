//
//  BridgeComponentFinder.m
//  omnifocus
//
//  Created by Christopher Schneider on 2/11/12.
//  Copyright 2012 Personal. All rights reserved.
//

#import "BridgeComponentFinder.h"

@implementation BridgeComponentFinder

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (omnifocusDocument*) getDocument {
    return [[self getOmnifocus] defaultDocument];
}

- (omnifocusApplication*) getOmnifocus {
    return [SBApplication applicationWithBundleIdentifier:@"com.omnigroup.OmniFocus"];
}

- (SBElementArray*) getInboxTasks {
    return [[self getDocument] inboxTasks];
}

- (Class) getTaskClass {   
    return [[self getOmnifocus ] classForScriptingClass:@"task"];
}

- (Class) getProjectClass {   
    return [[self getOmnifocus ] classForScriptingClass:@"project"];
}


- (omnifocusContext*) findContextByName: (NSString*)name {
    return [[[self getDocument] flattenedContexts] objectWithName:name];
}

- (omnifocusProject*) findProjectByName: (NSString*)name {
    return [[[self getDocument] flattenedProjects] objectWithName:name];
}

- (omnifocusProject*) findFuzzyProjectByName: (NSString*)name {
    return [self findProjectByName:[self fuzzyFindByName:name andType:@"project"]];
}
- (omnifocusContext*) findFuzzyContextByName: (NSString*)name {
    return [self findContextByName:[self fuzzyFindByName:name andType:@"context"]];
}

- (NSString*) fuzzyFindByName:(NSString*)name andType:(NSString*)type {
    NSString *s = [NSString stringWithFormat:
                   @"tell application \"OmniFocus\" to tell «property FCDo»\n"
                   @"\tset TheSearch to \"pivotal\"\n"
                   @"\tset ProjectArray to complete TheSearch as project maximum matches 1\n"
                   @"\treturn name of first item in ProjectArray\n"
                   @"end tell\n"
                   , name, type];
    
    NSAppleScript *scriptObj = [[NSAppleScript alloc] initWithSource:s];
    NSDictionary *compileErrInfo;
    [scriptObj compileAndReturnError:&compileErrInfo];
    
    if (scriptObj) {
        NSDictionary *errInfo;
        NSAppleEventDescriptor *aed = [scriptObj executeAndReturnError:&errInfo];
        [scriptObj release];
        if (aed) {
            return [aed stringValue];
        }
    }

}

//NSString *s = [NSString stringWithFormat:
//               @"tell application \"OmniFocus\"\n"
//               @"\ttell default document\n"
//               @"\t\tset ProjectArray to complete \"%@\" as %@ maximum matches 1\n"
//               @"\tend tell\n"
//               @"\treturn first item in ProjectArray\n"
//               @"end tell\n"
//               , name, type];
//NSString *return_value = nil;


@end
