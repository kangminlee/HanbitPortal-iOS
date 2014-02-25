//
//  BibleYearTableViewController.m
//  HanbitBibleMemory
//
//  Created by Jaehong Chon on 2/16/14.
//  Copyright (c) 2014 Hanbit Church. All rights reserved.
//

#import "BibleYearTableViewController.h"
#import "SWRevealViewController.h"

@interface BibleYearTableViewController ()

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;

@end

@implementation BibleYearTableViewController

// Method for creating button, with background image and other properties
- (void)addButton:(NSInteger)offset ButtonTitle:(NSString *)title
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(10, 70+offset*40, self.view.frame.size.width-20, 48);
    [button setTitle:title forState:UIControlStateNormal];
    button.backgroundColor = [UIColor clearColor];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    UIImage *buttonImageNormal = [UIImage imageNamed:@"rectangle_icon.png"];
    UIImage *strechableButtonImageNormal = [buttonImageNormal stretchableImageWithLeftCapWidth:12 topCapHeight:0];
    [button setBackgroundImage:strechableButtonImageNormal forState:UIControlStateNormal];
//    UIImage *buttonImagePressed = [UIImage imageNamed:@"whiteButton.png"];
//    UIImage *strechableButtonImagePressed = [buttonImagePressed stretchableImageWithLeftCapWidth:12 topCapHeight:0];
//    [playButton setBackgroundImage:strechableButtonImagePressed forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)buttonAction:(id)sender
{
//    NSLog(@"Button (%@) clicked.", sender);
}

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
    
    // Change button color
    _sidebarButton.tintColor = [UIColor colorWithWhite:0.1f alpha:0.9f];
    
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    // create button and views
    [self addButton:0 ButtonTitle:@"마태복음"];
    [self addButton:1 ButtonTitle:@"마가복음"];
    [self addButton:2 ButtonTitle:@"누가복음"];
    [self addButton:3 ButtonTitle:@"요한복음"];
    
    UIView *view1 = [UIView new];
    view1.frame = CGRectMake(0, 0, self.view.frame.size.width, 30 /*self.view.frame.size.height*/);
    [self.view addSubview:view1];
    
/*
    CGRect uiview1_original_rect = UIView_1.frame;
    CGRect uiview2_original_rect = UIView_2.frame;
    
    
    CGRect uiview2_translated_rect = CGRectMake(uiview2_original_rect.origin.x,
                                                uiview2_original_rect.origin.y+uiview1_original_rect.size.height,
                                                uiview2_original_rect.size.width,
                                                uiview2_original_rect.size.height);
    
    CGRect uiview2_resized_rect = CGRectMake(uiview2_original_rect.origin.x,
                                             uiview2_original_rect.origin.y+uiview1_original_rect.size.height,
                                             uiview2_original_rect.size.width,
                                             uiview2_original_rect.size.height-uiview1_original_rect.size.height);
    
    [UIView animateWithDuration:0.300 delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut| UIViewAnimationOptionBeginFromCurrentState
                        animations:^{
                         //uncomment this and comment out the other if you want to move UIView_2 down to show UIView_1
                         //UIView_2.frame = uiview2_translated_rect;
                         UIView_2.frame = uiview2_resized_rect;
                        } completion:^(BOOL finished) {
                         
                     }];
 */
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
