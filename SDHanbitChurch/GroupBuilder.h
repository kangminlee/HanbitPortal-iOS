//
//  GroupBuilder.h
//  SDHanbitChurch
//
//  Created by Jaehong Chon on 3/12/14.
//  Copyright (c) 2014 San Diego Hanbit Church. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GroupBuilder : NSObject

+ (NSArray *)groupsFromJSON:(NSData *)objectNotation error:(NSError **)error;

@end
