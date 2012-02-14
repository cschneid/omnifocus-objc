//
//  Task.m
//  omnifocus
//
//  Created by Christopher Schneider on 2/11/12.
//  Copyright 2012 Personal. All rights reserved.
//

#import "Task.h"

@implementation Task

- (id)init
{
    self = [super init];
    if (self) {
    }
    
    return self;
}

+ (void) createTaskFromEncodedString: (NSString*) taskString {
    BridgeComponentFinder *bridge = [[BridgeComponentFinder alloc] init ];
    
//    NSArray *tasks = [[bridge getOmnifocus] parseTasksWithTransportText:taskString asSingleTask:true];
//    [[bridge getInboxTasks] addObjectsFromArray:tasks];

    Class taskClass = [bridge getTaskClass];
    NSDictionary *dict = [Task parseTaskString:taskString usingBridge:bridge];
    
    omnifocusTask *oftask = [[taskClass alloc] initWithProperties:dict];

    [[bridge getInboxTasks] addObject:oftask];
}


// @context (fragment, no spaces)
// #project (fragment, no spaces)
// due(due date) (can be shortened as d(date))
// start(start date) (can be shortened as s(date))
// (notes)
// ! (sets task as flagged)
+ (NSDictionary*) parseTaskString: (NSString*) taskString usingBridge: (BridgeComponentFinder*) bridge {
    NSMutableString *str = [NSMutableString stringWithString:taskString];
    NSError *error;
    
    NSRegularExpression *regex_context = [NSRegularExpression regularExpressionWithPattern:@"@([^ ]+)" options:NSRegularExpressionCaseInsensitive error:&error];
    NSRegularExpression *regex_project = [NSRegularExpression regularExpressionWithPattern:@" ?#([a-z0-9]+)" options:NSRegularExpressionCaseInsensitive error:&error];
    NSRegularExpression *regex_due = [NSRegularExpression regularExpressionWithPattern:@" d(?:ue)?\\(([^\\)]+)\\)" options:NSRegularExpressionCaseInsensitive error:&error];
    NSRegularExpression *regex_start = [NSRegularExpression regularExpressionWithPattern:@" s(?:tart)?\\(([^\\)0]+)\\)" options:NSRegularExpressionCaseInsensitive error:&error];
    NSRegularExpression *regex_notes = [NSRegularExpression regularExpressionWithPattern:@"\\(([^\\)]+)\\)" options:NSRegularExpressionCaseInsensitive error:&error];
    NSRegularExpression *regex_flagged = [NSRegularExpression regularExpressionWithPattern:@" !\\Z" options:NSRegularExpressionCaseInsensitive error:&error];
    
    NSRange range;
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    
    // Flagged
    range = NSMakeRange(0, [str length]);
    NSTextCheckingResult *flagged = [regex_flagged firstMatchInString:str options:NSRegularExpressionCaseInsensitive range:range ];
    if ([flagged range].length > 0) {
        
        [dict setValue:@"true" forKey:@"flagged"];
    }
    [regex_flagged replaceMatchesInString:str options:NSRegularExpressionCaseInsensitive range:range withTemplate:@""];

    // Contexts
    range = NSMakeRange(0, [str length]);
    NSTextCheckingResult *context = [regex_context firstMatchInString:str options:NSRegularExpressionCaseInsensitive range:range ];
    if ([context range].length > 0) {
        NSString *context_str = [str substringWithRange:[context rangeAtIndex: 1]];
        omnifocusContext *context_obj = [bridge findContextByName:context_str];
        [dict setValue:context_obj forKey:@"context"];
    }
    [regex_context replaceMatchesInString:str options:NSRegularExpressionCaseInsensitive range:range withTemplate:@""];

    // Projects
    range = NSMakeRange(0, [str length]);
    NSTextCheckingResult *project = [regex_project firstMatchInString:str options:NSRegularExpressionCaseInsensitive range:range ];
    if ([project range].length > 0) {
        NSString *project_str = [str substringWithRange:[project rangeAtIndex: 1]];
        omnifocusProject *project_obj = [bridge findFuzzyProjectByName:project_str];
        [dict setValue:project_obj forKey:@"project"];
    }
    [regex_project replaceMatchesInString:str options:NSRegularExpressionCaseInsensitive range:range withTemplate:@""];
  
    // Due
    range = NSMakeRange(0, [str length]);
    NSTextCheckingResult *due = [regex_due firstMatchInString:str options:NSRegularExpressionCaseInsensitive range:range ];
    if ([due range].length > 0) {
        NSString *due_str = [str substringWithRange:[due rangeAtIndex: 1]];
        NSDate *due_date = [NSDate dateWithNaturalLanguageString:due_str];
        [dict setValue:due_date forKey:@"dueDate"];
    }
    [regex_due replaceMatchesInString:str options:NSRegularExpressionCaseInsensitive range:range withTemplate:@""];

    // Start
    range = NSMakeRange(0, [str length]);
    NSTextCheckingResult *start = [regex_start firstMatchInString:str options:NSRegularExpressionCaseInsensitive range:range ];
    if ([due range].length > 0) {
        NSString *start_str = [str substringWithRange:[start rangeAtIndex: 1]];
        NSDate *start_date = [NSDate dateWithNaturalLanguageString:start_str];
        [dict setValue:start_date forKey:@"startDate"];
    }
    [regex_start replaceMatchesInString:str options:NSRegularExpressionCaseInsensitive range:range withTemplate:@""];
    
    // Notes
    range = NSMakeRange(0, [str length]);
    NSTextCheckingResult *note = [regex_notes firstMatchInString:str options:NSRegularExpressionCaseInsensitive range:range ];
    if ([note range].length > 0) {
        NSString *notes_str = [str substringWithRange:[note rangeAtIndex: 1]];
        [dict setValue:notes_str forKey:@"note"];
    }
    [regex_notes replaceMatchesInString:str options:NSRegularExpressionCaseInsensitive range:range withTemplate:@""];

    
    // And Finally add what's left as the main text of the task
    [dict setValue:[NSString stringWithString: str] forKey:@"name"]; 

    return dict;
}


@end
