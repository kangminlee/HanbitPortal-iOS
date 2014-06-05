//
//  PageViewController.m
//  SDHanbitChurch
//
//  Created by Jaehong Chon on 3/2/14.
//  Copyright (c) 2014 San Diego Hanbit Church. All rights reserved.
//

#import "PageViewController.h"
#import "SWRevealViewController.h"

@interface PageViewController ()

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (weak, nonatomic) IBOutlet UIWebView *viewControl;

@end

@implementation PageViewController

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
    
    // Change button color
    _sidebarButton.tintColor = [UIColor colorWithWhite:0.1f alpha:0.9f];
    
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    if (_category == 201)
    {
        NSURL *url = [NSURL URLWithString:@"http://www.sdhanbit.org/?page_id=323"];
        NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
        [_viewControl loadRequest:requestObj];
    }
    else if (_category == 304)
    {
        NSURL *url = [NSURL URLWithString:@"http://www.sdhanbit.org/?page_id=190"];
        NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
        [_viewControl loadRequest:requestObj];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
