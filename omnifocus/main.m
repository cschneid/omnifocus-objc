//
//  main.m
//  omnifocus
//
//  Created by Christopher Schneider on 2/11/12.
//  Copyright 2012 Personal. All rights reserved.
//

#include "main.h"
#include <getopt.h>


int main (int argc, char * const argv[])
{
    parse_args(argc, argv);
    return 0;
}


void parse_args(int argc, char * const argv[]) {
    int ch;
    if (argc == 1) {
        usage();
        exit(0);
    }

    /* options descriptor */
    struct option longopts[] = {
        { "project",  required_argument,  NULL, 'p' },
        { "context",  required_argument,  NULL, 'c' },
        { "task",     required_argument,  NULL, 't' },
        { NULL,       0,                  NULL,  0   }
    };
    
    ch = getopt_long(argc, argv, "p:c:t:", longopts, NULL);
    switch (ch) {
    case 'p':
      printf("Project: %s\n", optarg);
      break;
    case 'c':
      printf("Context: %s\n", optarg);
      break;
    case 't':
      printf("Creating Task: %s\n", optarg);
      [Task createTaskFromEncodedString:[NSString stringWithCString:optarg encoding:NSASCIIStringEncoding]];
      break;
    case 0:
      break;
    default:
      usage();
    }
}

void usage() {
    printf("Usage: --project, --context, --task\n");
}
