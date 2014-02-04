//
//  MainViewController.m
//  HanbitBibleMemory
//
//  Created by Jaehong Chon on 1/26/14.
//  Copyright (c) 2014 Hanbit Church. All rights reserved.
//

#import "MainViewController.h"
#import "SWRevealViewController.h"
#import "BibleContextsTable.h"

@interface MainViewController ()

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (weak, nonatomic) IBOutlet UITextField *mainTitle;
@property (weak, nonatomic) IBOutlet UITextView *mainBible;
@property (weak, nonatomic) IBOutlet UIButton *mainThisWeek;
@property (weak, nonatomic) IBOutlet UIButton *mainDaily;

@end

@implementation MainViewController

NSInteger base2014ChVerse = 12*3 + 4; // based on 1st week of 2014
NSInteger thisWeekCh;
NSInteger thisWeekVerse;
NSInteger thisWeekDay;
NSInteger thisTimeHour;

- (void) getThisWeekInfo
{
    NSDate *now = [NSDate date];
    NSCalendar *calender = [NSCalendar currentCalendar];
    NSInteger thisWeekOfYear = [[calender components: NSWeekOfYearCalendarUnit fromDate:now] weekOfYear] - 1;
    thisWeekDay = [[calender components: NSWeekdayCalendarUnit fromDate:now] weekday];
    thisTimeHour = [[calender components: NSHourCalendarUnit fromDate:now] hour];
    
    if( thisWeekOfYear != 0 && thisWeekDay == 1 && thisTimeHour < 12) // sunday morning, still need to display the previous week
        thisWeekOfYear = thisWeekOfYear - 1;

    thisWeekCh = ((base2014ChVerse + thisWeekOfYear) / 12) % 5;
    thisWeekVerse = (base2014ChVerse + thisWeekOfYear) % 12;
}

- (IBAction) myThisWeekAction:(id)sender
{
    [self getThisWeekInfo];
    
    self.mainTitle.text = korTitleString[thisWeekCh][thisWeekVerse];
    if( thisWeekDay == 1 && thisTimeHour < 12 ) // sunday morning
        self.mainBible.text = korHideTextString[thisWeekCh][thisWeekVerse];
    else
        self.mainBible.text = korTextString[thisWeekCh][thisWeekVerse];
}

- (IBAction) myDailyAction:(id)sender
{
    NSInteger indexCh = arc4random() % 5;
    NSInteger indexVerse = arc4random() % 12;
    
    self.mainTitle.text = korTitleString[indexCh][indexVerse];
    self.mainBible.text = korTextString[indexCh][indexVerse];
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

    self.title = @"한빛교회 성경 암송";
    
    // Change button color
    _sidebarButton.tintColor = [UIColor colorWithWhite:0.1f alpha:0.9f];
    
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);

    // background
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"main.jpg"] drawInRect:self.view.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
    
    [self.mainThisWeek addTarget:self
                action:@selector(myThisWeekAction:)
                forControlEvents:UIControlEventTouchUpInside];
    
    [self.mainDaily addTarget:self
                action:@selector(myDailyAction:)
                forControlEvents:UIControlEventTouchUpInside];
    
    [self getThisWeekInfo];
    
    // this week's bible verse
    self.mainTitle.text = korTitleString[thisWeekCh][thisWeekVerse];
    if( thisWeekDay == 1 && thisTimeHour < 12 ) // sunday morning until 12PM
        self.mainBible.text = korHideTextString[thisWeekCh][thisWeekVerse];
    else
        self.mainBible.text = korTextString[thisWeekCh][thisWeekVerse];
    
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
