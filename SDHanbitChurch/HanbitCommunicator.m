//
//  HanbitCommunicator.m
//  SDHanbitChurch
//
//  Created by Jaehong Chon on 3/10/14.
//  Copyright (c) 2014 San Diego Hanbit Church. All rights reserved.
//

#import "HanbitCommunicator.h"
#import "HanbitCommunicatorDelegate.h"

#define PAGE_COUNT 20

@implementation HanbitCommunicator

- (void)searchItemsAtHanbit:(NSInteger)category
{
    NSString *urlAsString = [NSString stringWithFormat:@"http://www.sdhanbit.org/wordpress/wp_api/v1/posts?cat=%ld&include_found=yes&per_page=%d",
                             (long)category, PAGE_COUNT];
    NSURL *url = [[NSURL alloc] initWithString:urlAsString];
    NSLog(@"%@", urlAsString);
    
    [NSURLConnection sendAsynchronousRequest:[[NSURLRequest alloc] initWithURL:url]
                                       queue:[[NSOperationQueue alloc] init]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
    {
        if( error )
        {
            [self.delegate fetchingItemsFailedWithError:error];
        } else
        {
            [self.delegate receivedItemsJSON:data];
        }
    }];
}

@end
