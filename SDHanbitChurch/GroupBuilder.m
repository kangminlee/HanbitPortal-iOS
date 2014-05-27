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
    
    NSInteger found = [[parsedObject valueForKey:@"found"] intValue];
    NSLog(@"Found %d", found);
    
    NSArray *results = [parsedObject valueForKey:@"posts"];
    NSLog(@"Count %d", results.count);
    
    for( NSDictionary *groupDic in results )
    {
        for( NSString *key in groupDic )
        {
            NSString *value = [groupDic valueForKey:key];
            
            if( [key isEqual: @"title"])
                NSLog(@"%@: %@", key, value);
            
            if( [key isEqual: @"date"])
                NSLog(@"%@: %@", key, value);
            
            //if( [key isEqual: @"content"])
            //    NSLog(@"%@: %@", key, value);
            
            if( [key isEqual: @"taxonomies"])
            {
                NSDictionary *category = [[groupDic valueForKey:key] valueForKey:@"category"];
                for( NSString *subkey in category )
                {
                    NSLog(@"%@:category: %@", key, subkey);
                }
            }
            
            /* -- replace SQL codes here ----
            if ([group respondsToSelector:NSSelectorFromString(key)])
            {
                [group setValue:[groupDic valueForKey:key] forKey:key];
            }
             */
        }
    }
    
    return groups;
}

@end
