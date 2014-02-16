//
//  BibleMainViewController.m
//  HanbitBibleMemory
//
//  Created by Jaehong Chon on 2/14/14.
//  Copyright (c) 2014 Hanbit Church. All rights reserved.
//

#import "BibleMainViewController.h"
#import "BibleContextsTable.h"
#import "BibleViewController.h"

@interface BibleMainViewController ()

- (IBAction)bibleRecitation:(id)sender;

@end

@implementation BibleMainViewController

NSInteger myBibleStatus = 0;
NSInteger currentPageIndex;
NSInteger nextPageIndex;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

	// Do any additional setup after loading the view.
    UIPageControl *pageControl = [UIPageControl appearance];
    pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
    pageControl.backgroundColor = [UIColor whiteColor];
    
    // initialize
    myBibleStatus = 0;
    currentPageIndex = self.initalIndex;
    
    self.navigationItem.title = [NSString stringWithFormat:@"%d of 60 Pages", self.initalIndex + 1];
    
    // Create page view controller
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"BiblePageViewController"];
    self.pageViewController.dataSource = self;

    BibleViewController *startingViewController = [self viewControllerAtIndex:self.initalIndex];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    // Change the size of page view controller
    self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 30);
    
    [self addChildViewController:_pageViewController];
    [self.view addSubview:_pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BibleViewController *)viewControllerAtIndex:(NSInteger)index
{
    NSInteger bibleChapter = index / 12;
    NSInteger bibleIndex = index % 12;
    
    if( index >= MAX_BIBLE_VERSE ) {
        return nil;
    }
    
    // Create a new view controller and pass suitable data.
    BibleViewController *bibleViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"BibleViewController"];
    bibleViewController.pageIndex = index;
    bibleViewController.koreanTitle  = korTitleString[bibleChapter][bibleIndex];
    bibleViewController.englishTitle = engTitleString[bibleChapter][bibleIndex];
    
    switch( myBibleStatus ) {
        case 0:
            bibleViewController.koreanText   = korTextString[bibleChapter][bibleIndex];
            bibleViewController.englishText  = engTextString[bibleChapter][bibleIndex];
            break;
            
        case 1:
            bibleViewController.koreanText   = korHintTextString[bibleChapter][bibleIndex];
            bibleViewController.englishText  = engHintTextString[bibleChapter][bibleIndex];
            break;
            
        case 2:
            bibleViewController.koreanText   = korHideTextString[bibleChapter][bibleIndex];
            bibleViewController.englishText  = engHideTextString[bibleChapter][bibleIndex];
            break;
            
        default:
            break;
    }
    
    return bibleViewController;
}

#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = ((BibleViewController *) viewController).pageIndex;
    
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;

    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = ((BibleViewController *) viewController).pageIndex;
    
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    
    if (index == MAX_BIBLE_VERSE) {
        return nil;
    }
    
    return [self viewControllerAtIndex:index];
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return MAX_BIBLE_VERSE;
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return self.initalIndex;
}

- (IBAction)bibleRecitation:(id)sender
{
    myBibleStatus = (myBibleStatus + 1) % 3;

    BibleViewController *startingViewController = [self viewControllerAtIndex:currentPageIndex];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionReverse animated:NO completion:nil];
}

- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray *)pendingViewControllers
{
    BibleViewController* controller = [pendingViewControllers firstObject];
    nextPageIndex = controller.pageIndex;
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed
{
    if( completed )
    {
        currentPageIndex = nextPageIndex;
        self.navigationItem.title = [NSString stringWithFormat:@"%d of 60 Pages", currentPageIndex + 1];
    }
    
    nextPageIndex = 0;
}

@end
