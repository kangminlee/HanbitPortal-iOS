//
//  HanbitCommunicator.h
//  SDHanbitChurch
//
//  Created by Jaehong Chon on 3/10/14.
//  Copyright (c) 2014 San Diego Hanbit Church. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HanbitCommunicatorDelegate;

@interface HanbitCommunicator : NSObject

@property (weak, nonatomic) id<HanbitCommunicatorDelegate> delegate;

- (void)searchItemsAtHanbit:(NSInteger)category;

@end
