//
//  BibleTestViewController.m
//  HanbitBibleMemory
//
//  Created by Jaehong Chon on 2/2/14.
//  Copyright (c) 2014 Hanbit Church. All rights reserved.
//

#import "BibleTestViewController.h"
#import "SWRevealViewController.h"
#import "BibleContextsTable.h"

@interface BibleTestViewController ()

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
- (IBAction)bibleHintButton:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *bibleKoreanTitle;
@property (weak, nonatomic) IBOutlet UITextView *bibleKoreanTest;
@property (weak, nonatomic) IBOutlet UITextField *bibleEnglishTitle;
@property (weak, nonatomic) IBOutlet UITextView *bibleEnglishTest;

@end

@implementation BibleTestViewController

NSInteger bibleHintMode;
NSInteger bibleChapter;
NSInteger bibleIndex;

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
    
    // initialize
    bibleHintMode = 0;
    
    // random number between 0 to 59
    bibleChapter = arc4random() % 5;
    bibleIndex   = arc4random() % 12;
    
    self.bibleKoreanTitle.text  = korTitleString[bibleChapter][bibleIndex];
    self.bibleEnglishTitle.text = engTitleString[bibleChapter][bibleIndex];
    self.bibleKoreanTest.text   = korHideTextString[bibleChapter][bibleIndex];
    self.bibleEnglishTest.text  = engHideTextString[bibleChapter][bibleIndex];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)bibleHintButton:(id)sender
{
    bibleHintMode = (bibleHintMode + 1) % 3;
    
    switch( bibleHintMode ) {
        case 0:
            self.bibleKoreanTest.text  = korHideTextString[bibleChapter][bibleIndex];
            self.bibleEnglishTest.text = engHideTextString[bibleChapter][bibleIndex];
            break;
            
        case 1:
            self.bibleKoreanTest.text  = korHintTextString[bibleChapter][bibleIndex];
            self.bibleEnglishTest.text = engHintTextString[bibleChapter][bibleIndex];
            break;
            
        case 2:
            self.bibleKoreanTest.text  = korTextString[bibleChapter][bibleIndex];
            self.bibleEnglishTest.text = engTextString[bibleChapter][bibleIndex];
            break;
            
        default:
            break;
    }
    
}

@end
