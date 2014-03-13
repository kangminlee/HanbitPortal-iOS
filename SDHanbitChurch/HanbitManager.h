//
//  HanbitManager.h
//  SDHanbitChurch
//
//  Created by Jaehong Chon on 3/12/14.
//  Copyright (c) 2014 San Diego Hanbit Church. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "HanbitManagerDelegate.h"
#import "HanbitCommunicatorDelegate.h"

@class HanbitCommunicator;

@interface HanbitManager : NSObject

@property (strong, nonatomic) HanbitCommunicator *communicator;
@property (weak, nonatomic) id<HanbitManagerDelegate> delegate;

- (void)fetchGroupsAtHanbit:(NSInteger)category;

@end
