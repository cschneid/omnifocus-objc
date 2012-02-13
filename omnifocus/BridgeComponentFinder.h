//
//  BridgeComponentFinder.h
//  omnifocus
//
//  Created by Christopher Schneider on 2/11/12.
//  Copyright 2012 Personal. All rights reserved.
//

#ifndef omnifocus_bridge_component_finder_h
#define omnifocus_bridge_component_finder_h

#include "main.h"

@interface BridgeComponentFinder : NSObject
- (omnifocusApplication*)getOmnifocus;
- (omnifocusDocument*)getDocument;
- (SBElementArray*)getInboxTasks;
- (Class) getTaskClass;
- (Class) getProjectClass;
- (omnifocusContext*) findContextByName: (NSString*)name;
- (omnifocusProject*) findProjectByName: (NSString*)name;
- (omnifocusProject*) findFuzzyProjectByName: (NSString*)name;
- (NSString*) fuzzyFindByName:(NSString*)name andType:(NSString*)type;
@end

#endif
