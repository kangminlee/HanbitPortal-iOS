//
//  PageTableViewController.m
//  SDHanbitChurch
//
//  Created by Jaehong Chon on 3/2/14.
//  Copyright (c) 2014 San Diego Hanbit Church. All rights reserved.
//

#import "PageTableViewController.h"
#import "SWRevealViewController.h"
#import "ItemViewController.h"
#import "DBManager.h"

@interface PageTableViewController ()

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;

@end

@implementation PageTableViewController

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    ItemViewController *itemViewController = (ItemViewController *)segue.destinationViewController;
    itemViewController.category = _category;
    itemViewController.index    = [self.tableView indexPathForSelectedRow].row;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    // Change button color
    _sidebarButton.tintColor = [UIColor colorWithWhite:0.1f alpha:0.9f];
    
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
 
    NSString *titleString;
    switch (_category)
    {
        case 14:
            titleString = @"목회 칼럼";
            break;
        case 15:
            titleString = @"교회 소식";
            break;
        case 30:
            titleString = @"설교 동영상";
            break;
        case 61:
            titleString = @"설교 나눔";
            break;
        case 87:
            titleString = @"말씀의 씨앗";
            break;
        case 201:
            titleString = @"교회 소개";
            break;
        case 202:
            titleString = @"성경 암송";
            break;
        case 203:
            titleString = @"소망의 씨앗";
            break;
        case 204:
            titleString = @"금주 사역";
            break;
        default:
            NSLog(@"undefinded category");
            break;
    }
    self.title = titleString;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [DBManager numberOfItemsAtCategory:_category];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = nil;
    
    // dynamic information: 목회칼럼 (14), 교회소식/광고 (15), 설교동영상 (30), 설교나눔 (61), 말씀의 씨앗 (87)
    // static  information: 교회소개 (201), 성경암송 (202), 소망의 씨앗 (203), 금주사역 (204)
   switch (_category)
    {
        case 14:
            CellIdentifier = @"columnCell";
            break;
        case 15:
            CellIdentifier = @"newsCell";
            break;
        case 30:
            CellIdentifier = @"sermonCell";
            break;
        case 61:
            CellIdentifier = @"shareCell";
            break;
        case 87:
            CellIdentifier = @"noteCell";
            break;
        case 202:
            CellIdentifier = @"bibleCell";
            break;
        default:
            NSLog(@"undefinded category");
            break;
    }

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    NSArray *listOfItems = [DBManager getItemDetailInfo:_category Index:indexPath.row];
    
    if (cell == nil || listOfItems == nil)
        return cell;
    
    DBManager *data = [listOfItems objectAtIndex:0];
    
    UILabel *tableLabelTitle = (UILabel *)[cell viewWithTag:100];
    tableLabelTitle.text = data->_title;

    NSRange strYearRange = {0,4}, strMonthRange = {4,2}, strDayRange = {6,2};
    UILabel *tableLabelDate = (UILabel *)[cell viewWithTag:101];
    tableLabelDate.text = [NSString stringWithFormat:@"%@-%@-%@",
                           [data->_pubdate substringWithRange:strYearRange],
                           [data->_pubdate substringWithRange:strMonthRange],
                           [data->_pubdate substringWithRange:strDayRange]];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
