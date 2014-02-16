//
//  BibleListViewController.m
//  HanbitBibleMemory
//
//  Created by Jaehong Chon on 1/28/14.
//  Copyright (c) 2014 Hanbit Church. All rights reserved.
//

#import "BibleListViewController.h"
#import "SWRevealViewController.h"
#import "BibleMainViewController.h"
#import "BibleContextsTable.h"

@interface BibleListViewController ()

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;

@end

@implementation BibleListViewController

NSArray *bibleList[5];

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    BibleMainViewController *bibleMainController = (BibleMainViewController *)segue.destinationViewController;
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    bibleMainController.initalIndex = (indexPath.row / 13)*12 + ((indexPath.row % 13) - 1);
}

- (void) loadBibleListData:(NSInteger)index
{
    bibleList[index] = @[korCategoryString[index],
                        [NSString stringWithFormat:@"%@ - %@", korMidTitleString[index][0], korTitleString[index][0]],
                        [NSString stringWithFormat:@"%@ - %@", korMidTitleString[index][0], korTitleString[index][1]],
                        [NSString stringWithFormat:@"%@ - %@", korMidTitleString[index][1], korTitleString[index][2]],
                        [NSString stringWithFormat:@"%@ - %@", korMidTitleString[index][1], korTitleString[index][3]],
                        [NSString stringWithFormat:@"%@ - %@", korMidTitleString[index][2], korTitleString[index][4]],
                        [NSString stringWithFormat:@"%@ - %@", korMidTitleString[index][2], korTitleString[index][5]],
                        [NSString stringWithFormat:@"%@ - %@", korMidTitleString[index][3], korTitleString[index][6]],
                        [NSString stringWithFormat:@"%@ - %@", korMidTitleString[index][3], korTitleString[index][7]],
                        [NSString stringWithFormat:@"%@ - %@", korMidTitleString[index][4], korTitleString[index][8]],
                        [NSString stringWithFormat:@"%@ - %@", korMidTitleString[index][4], korTitleString[index][9]],
                        [NSString stringWithFormat:@"%@ - %@", korMidTitleString[index][5], korTitleString[index][10]],
                        [NSString stringWithFormat:@"%@ - %@", korMidTitleString[index][5], korTitleString[index][11]]];
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

    // Change button color
    _sidebarButton.tintColor = [UIColor colorWithWhite:0.1f alpha:0.9f];
    
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    [self loadBibleListData:0]; // self.bibleChapter
    [self loadBibleListData:1];
    [self loadBibleListData:2];
    [self loadBibleListData:3];
    [self loadBibleListData:4];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    NSInteger i, totalRowCount = 0;
    
    for( i=0; i<5; i++ )
        totalRowCount += [bibleList[i] count];
    
    // Return the number of rows in the section.
    return totalRowCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger index = indexPath.row / 13;
    static NSString *CellIdentifier = nil;

    if( indexPath.row % 13 == 0 )
        CellIdentifier = @"bibleListChapter";
    else
        CellIdentifier = @"bibleListTable";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    NSString *bibleListChapter = [bibleList[index] objectAtIndex:indexPath.row % 13];
    if( indexPath.row % 13 == 0 )
    {
        cell.textLabel.text = bibleListChapter;
    }
    else
    {
        UILabel *bibleListTableLabel = (UILabel *)[cell viewWithTag:100];
        bibleListTableLabel.text = bibleListChapter;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if( indexPath.row % 13 == 0 )
        return 22;
    else
        return 40;
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
