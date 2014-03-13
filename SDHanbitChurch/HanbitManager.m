//
//  HanbitManager.m
//  SDHanbitChurch
//
//  Created by Jaehong Chon on 3/12/14.
//  Copyright (c) 2014 San Diego Hanbit Church. All rights reserved.
//

#import "HanbitManager.h"
#import "GroupBuilder.h"
#import "HanbitCommunicator.h"

@implementation HanbitManager

- (void)fetchGroupsAtHanbit:(NSInteger)category
{
    [self.communicator searchItemsAtHanbit:category];
}

#pragma mark - HanbitCommunicatorDelegate

- (void)receivedItemsJSON:(NSData *)objectNotation
{
    NSError *error = nil;
    NSArray *groups = [GroupBuilder groupsFromJSON:objectNotation error:&error];
    
    if (error != nil)
    {
        [self.delegate fetchingGroupsFailedWithError:error];
        
    } else
    {
        [self.delegate didReceiveGroups:groups];
    }
}

- (void)fetchingGroupsFailedWithError:(NSError *)error
{
    [self.delegate fetchingGroupsFailedWithError:error];
}

@end
