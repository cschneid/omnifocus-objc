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
    return [[[self getOmnifocus] complete:name 
                                      as:[NSNumber numberWithInt:[[NSAppleEventDescriptor descriptorWithString:@"project"] int32Value]]
            ] objectAtIndex:0];
}

@end
