//
//  MainPageViewController.m
//  SDHanbitChurch
//
//  Created by Jaehong Chon on 3/1/14.
//  Copyright (c) 2014 San Diego Hanbit Church. All rights reserved.
//

#import "MainPageViewController.h"
#import "SWRevealViewController.h"
#import "PageTableViewController.h"
#import "HanbitManager.h"
#import "HanbitCommunicator.h"
#import "DBManager.h"

@interface MainPageViewController () <HanbitManagerDelegate> {
    NSArray *_groups;
    HanbitManager *_manager;
}

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
- (IBAction)mainButton01:(id)sender;
- (IBAction)mainButton02:(id)sender;
- (IBAction)mainButton03:(id)sender;
- (IBAction)mainButton04:(id)sender;
- (IBAction)mainButton05:(id)sender;
- (IBAction)mainButton06:(id)sender;
- (IBAction)mainButton07:(id)sender;
- (IBAction)mainButton08:(id)sender;
- (IBAction)mainButton09:(id)sender;

@end

@implementation MainPageViewController

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    PageTableViewController *pageTableController = (PageTableViewController *)segue.destinationViewController;
    pageTableController.category = _selectedCategory;
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
    
    // Change button color
    _sidebarButton.tintColor = [UIColor colorWithWhite:0.1f alpha:0.9f];
    
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];

    self.title = @"샌디에고 한빛교회";
  
    _manager = [[HanbitManager alloc] init];
    _manager.communicator = [[HanbitCommunicator alloc] init];
    _manager.communicator.delegate = _manager;
    _manager.delegate = self;
    
    // get the current date and time info
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyyMMddHHmm"];
    
    NSDate *now = [[NSDate alloc] init];
    NSString *dateString = [format stringFromDate:now];
    long long dateStringInt = [dateString longLongValue];
    
    // read the database to get the latest updated date for each category
    [DBManager prepareDatabase];
    //[DBManager deleteAllItems];
    
    NSLog( @"[database] total:%d, cat14:%d, cat15:%d, cat30:%d, cat61:%d, cat87:%d",
          [DBManager numberOfTotalItems],
          [DBManager numberOfItemsAtCategory:14],
          [DBManager numberOfItemsAtCategory:15],
          [DBManager numberOfItemsAtCategory:30],
          [DBManager numberOfItemsAtCategory:61],
          [DBManager numberOfItemsAtCategory:87]);

    // 목회칼럼 (14), 교회소식/광고 (15), 설교동영상 (30), 설교나눔 (61), 말씀의 씨앗 (87)
    NSInteger tableCategory[5] = {14, 15, 30, 61, 87};
    for (int i=0; i<5; i++)
    {
        NSInteger category = tableCategory[i];
        
        NSString *latestRequestDate = [DBManager getLatestRequestDate:category];
        if (latestRequestDate == nil)
        {
            latestRequestDate = @"201401010000";
            
            [DBManager addItemsToDatabase:category
                                 Category:9999
                               UpdateDate:latestRequestDate
                                    Title:@"N/A" PubDate:@"N/A" permLink:@"N/A" Content:@"NA"];
        }
        NSLog(@"cat:%d, latestRequestDate:%@", category, latestRequestDate);
        
        // access the web server when last update is more than 12 hours ago
        long long latestRequestInt = [latestRequestDate longLongValue];
        if (dateStringInt - latestRequestInt > 1200)
        {
            [DBManager updateLatestRequestDate:category NewRequestDate:dateString];
            
            NSString *latestPubDate = [DBManager getLatestPubDate:category];
            [_manager fetchGroupsAtHanbit:category After:latestPubDate];
        }
    }
    
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(startFetchingGroups:)
//                                                 name:@"HanbitDataReceived"
//                                               object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 목회칼럼 (14), 교회소식/광고 (15), 설교동영상 (30), 설교나눔 (61), 말씀의 씨앗 (87)
// 교회소개 (201), 성경암송 (202), 소망의 씨앗 (203), 금주사역 (204)
- (IBAction)mainButton01:(id)sender
{
    _selectedCategory = 201;
}

- (IBAction)mainButton02:(id)sender
{
    _selectedCategory = 30;
}

- (IBAction)mainButton03:(id)sender
{
    _selectedCategory = 61;
}

- (IBAction)mainButton04:(id)sender
{
    _selectedCategory = 14;
}

- (IBAction)mainButton05:(id)sender
{
    _selectedCategory = 87;
}

- (IBAction)mainButton06:(id)sender
{
    _selectedCategory = 202;
}

- (IBAction)mainButton07:(id)sender
{
    _selectedCategory = 15;
}

- (IBAction)mainButton08:(id)sender
{
    _selectedCategory = 203;
}

- (IBAction)mainButton09:(id)sender
{
    _selectedCategory = 204;
}

#pragma mark - Notification Observer
- (void)startFetchingGroups:(NSInteger)category From:(NSString *)date //(NSNotification *)notification
{
    [_manager fetchGroupsAtHanbit:category After:date];
}

#pragma mark - MeetupManagerDelegate
- (void)didReceiveGroups:(NSArray *)groups
{
    _groups = groups;

    NSLog(@"finally got the info from the delegate\n");
    // update Badge information at Main View
    //[self.tableView reloadData];
}

- (void)fetchingGroupsFailedWithError:(NSError *)error
{
    NSLog(@"Error %@; %@", error, [error localizedDescription]);
}

@end
