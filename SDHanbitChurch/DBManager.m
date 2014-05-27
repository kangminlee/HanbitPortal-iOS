//
//  DBManager.m
//  SDHanbitChurch
//
//  Created by Jaehong Chon on 5/25/14.
//  Copyright (c) 2014 San Diego Hanbit Church. All rights reserved.
//

#import "DBManager.h"

@implementation DBManager

NSString *databasePath;
sqlite3 *myDatabase;

- (id)initWithContents:(NSInteger)category title:(NSString *)title pubdate:(NSString *)pubdate content:(NSString *)content
{
    if ((self = [super init]))
    {
        self->_category = category;
        self->_title    = title;
        self->_pubdate  = pubdate;
        self->_content  = content;
    }
    
    return self;
}

+ (BOOL) prepareDatabase
{
    BOOL isSuccess = YES;
    
    // Get the documents directory
    NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = dirPaths[0];
    
    // Build the path to the database file. We declared databasePath on Step 7
    databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent:@"sdhanbit.db"]];
    NSLog(@"DB Path: %@", databasePath);
    
    NSFileManager *filemgr = [NSFileManager defaultManager];
    if ([filemgr fileExistsAtPath: databasePath] == NO)
    {
        const char *dbpath = [databasePath UTF8String];
        if (sqlite3_open(dbpath, &myDatabase) == SQLITE_OK)
        {
            char *errMsg;
            const char *sql_stmt = "CREATE TABLE IF NOT EXISTS SDHANBITCONTENTS (ID INTEGER PRIMARY KEY, CAT INTEGER, UPDATEDATE TEXT, TITLE TEXT, PUBDATE TEXT, LINK TEXT, CONTENT TEXT)";

            if (sqlite3_exec(myDatabase, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK)
            {
                isSuccess = NO;
            }
            
            sqlite3_close(myDatabase);
        }
    }
    
    return isSuccess;
}

+ (BOOL) addItemsToDatabase:(NSInteger)identifier Category:(NSInteger)cat UpdateDate:(NSString*)updatedate Title:(NSString *)title PubDate:(NSString *)pubdate permLink:(NSString *)link Content:(NSString *)content
{
    BOOL isSuccess = NO;
    sqlite3_stmt *statement;
    const char   *dbpath = [databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &myDatabase) == SQLITE_OK)
    {
        NSString *insertSQL = [NSString stringWithFormat:
                               @"INSERT INTO SDHANBITCONTENTS (ID, CAT, UPDATEDATE, TITLE, PUBDATE, LINK, CONTENT) VALUES (\"%d\", \"%d\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\")",
                               identifier, cat, updatedate, title, pubdate, link, content];
        
        const char *insert_stmt = [insertSQL UTF8String];
        sqlite3_prepare_v2(myDatabase, insert_stmt,  -1, &statement, NULL);
        
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            isSuccess = YES;
        }
        
        sqlite3_finalize(statement);
        sqlite3_close(myDatabase);
    }
    
    return isSuccess;
}

+ (NSArray*) findItemsByCategory:(NSInteger)category
{
    const char *dbpath = [databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &myDatabase) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:
                              @"SELECT TITLE, PUBDATE, CONTENT FROM SDHANBITCONTENTS WHERE CAT=\"%d\"", category];
        const char *query_stmt = [querySQL UTF8String];
        sqlite3_stmt *statement = nil;
        NSMutableArray *resultArray = [[NSMutableArray alloc] init];
        
        if (sqlite3_prepare_v2(myDatabase, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                NSString *title = [[NSString alloc] initWithUTF8String:
                                  (const char *) sqlite3_column_text(statement, 0)];
                NSString *pubdate = [[NSString alloc] initWithUTF8String:
                                     (const char *) sqlite3_column_text(statement, 1)];
                NSString *content = [[NSString alloc]initWithUTF8String:
                                     (const char *) sqlite3_column_text(statement, 2)];

                DBManager *info = [[DBManager alloc] initWithContents:category title:title pubdate:pubdate content:content];
                [resultArray addObject:info];
            }
        }
        
        sqlite3_finalize(statement);
        sqlite3_close(myDatabase);
        
        return resultArray;
    }
    
    return nil;
}

+ (NSString*) getLatestUpdateDate
{
    const char *dbpath = [databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &myDatabase) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:
                              @"SELECT UPDATEDATE FROM SDHANBITCONTENTS WHERE ID=\"%lld\"", sqlite3_last_insert_rowid(myDatabase)];
        const char *query_stmt = [querySQL UTF8String];
        sqlite3_stmt *statement = nil;
        NSString *latestUpdateDate = nil;
        
        if (sqlite3_prepare_v2(myDatabase, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                latestUpdateDate = [[NSString alloc] initWithUTF8String:
                                    (const char *) sqlite3_column_text(statement, 0)];
            }
            
        }
        
        sqlite3_finalize(statement);
        sqlite3_close(myDatabase);
        
        return latestUpdateDate;
    }
    
    return nil;
}


@end
