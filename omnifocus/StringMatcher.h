//
//  StringMatcher.h
//  omnifocus
//
//  Created by Christopher Schneider on 2/11/12.
//  Copyright 2012 Personal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StringMatcher : NSObject

-(float)compareString:(NSString *)originalString withString:(NSString *)comparisonString;
-(NSInteger)smallestOf:(NSInteger)a andOf:(NSInteger)b andOf:(NSInteger)c;
-(NSInteger)smallestOf:(NSInteger)a andOf:(NSInteger)b;

@end
