//
//  MainPageViewController.m
//  SDHanbitChurch
//
//  Created by Jaehong Chon on 3/1/14.
//  Copyright (c) 2014 San Diego Hanbit Church. All rights reserved.
//

#import "MainPageViewController.h"
#import "SWRevealViewController.h"
#import "HanbitManager.h"
#import "HanbitCommunicator.h"
#import "DBManager.h"

@interface MainPageViewController () <HanbitManagerDelegate> {
    NSArray *_groups;
    HanbitManager *_manager;
}

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
- (IBAction)mainButton1:(id)sender;

@end

@implementation MainPageViewController

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
    [DBManager deleteItemsBeforePubDate:@"201405301200"];
    
    NSLog( @"[database] cat14:%d, cat15:%d, cat30:%d, cat61:%d, cat87:%d",
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
                                 Category:0
                               UpdateDate:latestRequestDate
                                    Title:@"N/A" PubDate:@"N/A" permLink:@"N/A" Content:@"NA"];
        }
        
        long long latestRequestInt = [latestRequestDate longLongValue];
        
        // access the web server when last update is more than 12 hours ago
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

- (IBAction)mainButton1:(id)sender
{
    
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
