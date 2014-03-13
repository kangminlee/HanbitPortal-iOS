//
//  GroupBuilder.m
//  SDHanbitChurch
//
//  Created by Jaehong Chon on 3/12/14.
//  Copyright (c) 2014 San Diego Hanbit Church. All rights reserved.
//

#import "GroupBuilder.h"

@implementation GroupBuilder

+ (NSArray *)groupsFromJSON:(NSData *)objectNotation error:(NSError **)error
{
    NSError *localError = nil;
    NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:objectNotation options:0 error:&localError];
    
    if (localError != nil)
    {
        *error = localError;
        return nil;
    }
    
    NSMutableArray *groups = [[NSMutableArray alloc] init];
    
    long found = [parsedObject valueForKey:@"found"];
    NSLog(@"Found %ld", found);
    
    NSArray *results = [parsedObject valueForKey:@"posts"];
    NSLog(@"Count %d", results.count);
    
    for (NSDictionary *groupDic in results)
    {
/* -- replace SQL codes here ----
        Group *group = [[Group alloc] init];
        
        for (NSString *key in groupDic)
        {
            if ([group respondsToSelector:NSSelectorFromString(key)])
            {
                [group setValue:[groupDic valueForKey:key] forKey:key];
            }
        }
        
        [groups addObject:group];
 */
    }
    
    return groups;
}

@end
