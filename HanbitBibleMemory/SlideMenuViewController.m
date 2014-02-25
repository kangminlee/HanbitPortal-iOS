//
//  SlideMenuViewController.m
//  HanbitBibleMemory
//
//  Created by Jaehong Chon on 1/26/14.
//  Copyright (c) 2014 Hanbit Church. All rights reserved.
//

#import "SlideMenuViewController.h"
#import "SWRevealViewController.h"
#import "BibleListViewController.h"
#import "BibleViewController.h"
#import "BibleContextsTable.h"

@interface SlideMenuViewController ()

@property (nonatomic, strong) NSArray *menuItems;

@end

@implementation SlideMenuViewController

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

    self.view.backgroundColor = [UIColor colorWithWhite:0.2f alpha:1.0f];
    self.tableView.backgroundColor = [UIColor colorWithWhite:0.2f alpha:1.0f];
    self.tableView.separatorColor = [UIColor colorWithWhite:0.15f alpha:0.2f];
    
    self.menuItems = @[@"Hanbit Church",
                       @"성경 암송 60 구절",
                       @"성경 암송 모의 시험",
                       //@"성경 읽기표",
                       @"의견 주세요!"];
    
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
    // Return the number of rows in the section.
    return [self.menuItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = nil;
    NSString *imageName = nil;
    
    switch (indexPath.row) {
        case 0:
            CellIdentifier = @"title";
            break;
            
        case 1:
            CellIdentifier = @"bibleList";
            imageName = @"bible-icon.png";
            break;
            
        case 2:
            CellIdentifier = @"bibleTest";
            imageName = @"test-paper-icon.png";
            break;
            
        case 4:
            CellIdentifier = @"bibleTable";
            imageName = @"table-icon.png";
            break;
            
        case 3:
            CellIdentifier = @"feedback";
            imageName = @"email-open.png";
            break;
            
        default:
            break;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    if( indexPath.row > 0 )
    {
        UIImageView *menuImageView = (UIImageView *)[cell viewWithTag:100];
        menuImageView.image = [UIImage imageNamed:imageName];
        
        NSString *menuName = [self.menuItems objectAtIndex:indexPath.row];
        UILabel *menuNameLabel = (UILabel *)[cell viewWithTag:101];
        menuNameLabel.text = menuName; //cell.textLabel.text = menuName;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (void) prepareForSegue: (UIStoryboardSegue *) segue sender: (id) sender
{
    // Set the title of navigation bar by using the menu items
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    UINavigationController *destViewController = (UINavigationController*)segue.destinationViewController;
    destViewController.title = [[self.menuItems objectAtIndex:indexPath.row] capitalizedString];
    
    // Set the bible if it navigates to the BibleView
    if( indexPath.row > 0 && [segue.identifier isEqualToString:@"showBible"] ) {
        BibleListViewController *bibleListController = (BibleListViewController*)segue.destinationViewController;
        bibleListController.bibleChapter = indexPath.row - 1;
    }
    
    if( [segue.identifier isEqualToString:@"sendFeedback"] )
    {
    }
    
    if( [segue isKindOfClass: [SWRevealViewControllerSegue class]] ) {
        SWRevealViewControllerSegue *swSegue = (SWRevealViewControllerSegue*) segue;
        
        swSegue.performBlock = ^(SWRevealViewControllerSegue* rvc_segue, UIViewController* svc, UIViewController* dvc) {
            UINavigationController* navController = (UINavigationController*)self.revealViewController.frontViewController;
            [navController setViewControllers: @[dvc] animated: NO];
            [self.revealViewController setFrontViewPosition: FrontViewPositionLeft animated: YES];
        };
    }
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
