//
//  DBManager.h
//  SDHanbitChurch
//
//  Created by Jaehong Chon on 5/25/14.
//  Copyright (c) 2014 San Diego Hanbit Church. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface DBManager : NSObject {
@public
    NSInteger _category;
    NSString *_title;
    NSString *_pubdate;
    NSString *_content;
    
}

- (id)initWithContents:(NSInteger)category title:(NSString *)title pubdate:(NSString *)pubdate content:(NSString *)content;

+ (BOOL) prepareDatabase;
+ (BOOL) addItemsToDatabase:(NSInteger)identifier Category:(NSInteger)cat UpdateDate:(NSString*)updatedate Title:(NSString *)title PubDate:(NSString *)pubdate permLink:(NSString *)link Content:(NSString *)content;
+ (NSArray*) findListOfItemsAtCategory:(NSInteger)category;
+ (NSArray*) getItemDetailInfo:(NSInteger)category Index:(NSInteger)index;
+ (NSInteger) numberOfTotalItems;
+ (NSInteger) numberOfItemsAtCategory:(NSInteger)category;
+ (BOOL) deleteAllItems;
+ (BOOL) deleteItemsBeforePubDate:(NSString *)pubDate;
+ (NSString*) getLatestRequestDate:(NSInteger)category;
+ (NSString*) getLatestPubDate:(NSInteger)category;
+ (BOOL) updateLatestRequestDate:(NSInteger)category NewRequestDate:(NSString *)newUpdateDate;

@end
