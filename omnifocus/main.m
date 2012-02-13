//
//  main.m
//  omnifocus
//
//  Created by Christopher Schneider on 2/11/12.
//  Copyright 2012 Personal. All rights reserved.
//

#include "main.h"

int main (int argc, const char * argv[])
{

    NSString *name;
    if (argc > 1) {
        name = [NSString stringWithCString:argv[1] encoding:NSASCIIStringEncoding] ;
    } else { 
        name = @"from obj-c when there wasn't an arg @Work d(tomorrow 6am) s(now) #pivotal ";
    }

    [Task createTaskFromDictionary:name];

    return 0;
}
