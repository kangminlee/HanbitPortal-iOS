//
//  ItemViewController.m
//  SDHanbitChurch
//
//  Created by Jaehong Chon on 6/1/14.
//  Copyright (c) 2014 San Diego Hanbit Church. All rights reserved.
//

#import "ItemViewController.h"
#import "DBManager.h"

@interface ItemViewController ()

@property (strong, nonatomic) IBOutlet UIWebView *viewItem;

@end

@implementation ItemViewController

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
    
    NSArray *listOfItems = [DBManager getItemDetailInfo:_category Index:_index];
    if (listOfItems != nil)
    {
        DBManager *data = [listOfItems objectAtIndex:0];
    
        NSString *htmlString = [NSString stringWithFormat:
                                @"<p><font size=\"4\" style=\"color:#8258FA\">%@</font></p>%@<br>",
                                data->_title, data->_content];
        [_viewItem loadHTMLString:htmlString baseURL:nil];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
