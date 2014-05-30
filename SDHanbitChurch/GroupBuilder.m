//
//  GroupBuilder.m
//  SDHanbitChurch
//
//  Created by Jaehong Chon on 3/12/14.
//  Copyright (c) 2014 San Diego Hanbit Church. All rights reserved.
//

#import "GroupBuilder.h"
#import "DBManager.h"

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
    
    // get the current date and time info
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyyMMddHHmm"];
    
    NSDate *now = [[NSDate alloc] init];
    NSString *dateString = [format stringFromDate:now];
    
    NSMutableArray *groups = [[NSMutableArray alloc] init];
    
    NSInteger found = [[parsedObject valueForKey:@"found"] intValue];
    NSLog(@"Found %d", found);
    
    NSArray *results = [parsedObject valueForKey:@"posts"];
    NSLog(@"Count %d", results.count);
    
    if (results.count == 0) // TBD, should be updated one by one.. but how??
    {
//        [DBManager updateLatestUpdateDate:14 NewUpdateDate:dateString];
//        [DBManager updateLatestUpdateDate:15 NewUpdateDate:dateString];
//        [DBManager updateLatestUpdateDate:30 NewUpdateDate:dateString];
//        [DBManager updateLatestUpdateDate:61 NewUpdateDate:dateString];
//        [DBManager updateLatestUpdateDate:87 NewUpdateDate:dateString];
    }
    
    for( NSDictionary *groupDic in results )
    {
        NSString *identifier = nil;
        NSString *cat = nil;
        NSString *title = nil;
        NSString *date = nil;
        NSString *permalink = nil;
        NSString *content = nil;
        
        for( NSString *key in groupDic )
        {
            NSString *value = [groupDic valueForKey:key];

            if( [key isEqual: @"id_str"])
                identifier = value;
            
            if( [key isEqual: @"title"])
                title = value;
            
            if( [key isEqual: @"date"])
                date = value;
            
            if( [key isEqual: @"permalink"])
                permalink = value;
            
            if( [key isEqual: @"content"])
            {
                content = value;
            }
            
            if( [key isEqual: @"taxonomies"])
            {
                NSDictionary *category = [[groupDic valueForKey:key] valueForKey:@"category"];
                for( NSString *subkey in category )
                {
                    cat = subkey;
                    //NSLog(@"%@:category: %@", key, subkey);
                }
            }
            
            /* -- replace SQL codes here ----
            if ([group respondsToSelector:NSSelectorFromString(key)])
            {
                [group setValue:[groupDic valueForKey:key] forKey:key];
            }
             */
            
        }
        
        //NSLog(@"%@, %@, %@, %@", identifier, cat, title, date);
        
        // update the database
        [DBManager addItemsToDatabase:[identifier intValue]
                             Category:[cat intValue]
                           UpdateDate:dateString
                                Title:title
                              PubDate:date
                             permLink:permalink
                              Content:content];
    }
    
    return groups;
}

@end
