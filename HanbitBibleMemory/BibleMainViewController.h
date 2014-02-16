//
//  BibleMainViewController.h
//  HanbitBibleMemory
//
//  Created by Jaehong Chon on 2/14/14.
//  Copyright (c) 2014 Hanbit Church. All rights reserved.
//

#import <UIKit/UIKit.h>

#define MAX_BIBLE_VERSE 60

@interface BibleMainViewController : UIViewController <UIPageViewControllerDataSource>

@property (strong, nonatomic) UIPageViewController *pageViewController;
@property NSInteger initalIndex;

@end
