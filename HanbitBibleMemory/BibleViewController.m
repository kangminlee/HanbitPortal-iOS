//
//  BibleViewController.m
//  HanbitBibleMemory
//
//  Created by Jaehong Chon on 1/27/14.
//  Copyright (c) 2014 Hanbit Church. All rights reserved.
//

#import "BibleViewController.h"
#import "BibleContextsTable.h"

@interface BibleViewController ()

@property (weak, nonatomic) IBOutlet UITextField *bibleKoreanTitle;
@property (weak, nonatomic) IBOutlet UITextField *bibleEnglishTitle;
@property (weak, nonatomic) IBOutlet UITextView *bibleKorean;
@property (weak, nonatomic) IBOutlet UITextView *bibleEnglish;
@property (weak, nonatomic) IBOutlet UIButton *bibleLeft;
@property (weak, nonatomic) IBOutlet UIButton *bibleRight;
@property (weak, nonatomic) IBOutlet UIButton *bibleRecitation;

@end

@implementation BibleViewController

NSInteger myBibleStatus = 0;

- (void) loadBibleVerse
{
    self.bibleKoreanTitle.text  = korTitleString[self.bibleChapter][self.bibleIndex];
    self.bibleEnglishTitle.text = engTitleString[self.bibleChapter][self.bibleIndex];
    
    switch (myBibleStatus)
    {
        case 0:
            self.bibleKorean.text  = korTextString[self.bibleChapter][self.bibleIndex];
            self.bibleEnglish.text = engTextString[self.bibleChapter][self.bibleIndex];
            break;
        
        case 1:
            self.bibleKorean.text  = korHintTextString[self.bibleChapter][self.bibleIndex];
            self.bibleEnglish.text = engHintTextString[self.bibleChapter][self.bibleIndex];
            break;
        
        case 2:
            self.bibleKorean.text  = korHideTextString[self.bibleChapter][self.bibleIndex];
            self.bibleEnglish.text = engHideTextString[self.bibleChapter][self.bibleIndex];
            break;
        
        default:
            break;
    }
}

- (IBAction) myBibleLeftAction:(id)sender
{
    if( self.bibleIndex > 0 )
        self.bibleIndex = self.bibleIndex - 1;
    else if( self.bibleChapter > 0 )
    {
        self.bibleChapter = self.bibleChapter - 1;
        self.bibleIndex = 11;
    }
    
    [self loadBibleVerse];
}

- (IBAction) myBibleRightAction:(id)sender
{
    if( self.bibleIndex < 11 )
        self.bibleIndex = self.bibleIndex + 1;
    else if( self.bibleChapter < 4 )
    {
        self.bibleChapter = self.bibleChapter + 1;
        self.bibleIndex = 0;
    }
    
    [self loadBibleVerse];
}

- (IBAction) myBibleRecitationAction:(id)sender
{
    myBibleStatus = (myBibleStatus + 1) % 3;
    
    [self loadBibleVerse];
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

    // background
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"skyyel2.jpg"] drawInRect:self.view.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];

    // initialize
    myBibleStatus = 0;
    
    // display bible verse
    [self loadBibleVerse];
    
    [self.bibleLeft addTarget:self
              action:@selector(myBibleLeftAction:)
              forControlEvents:UIControlEventTouchUpInside];

    [self.bibleRight addTarget:self
              action:@selector(myBibleRightAction:)
              forControlEvents:UIControlEventTouchUpInside];

    [self.bibleRecitation addTarget:self
              action:@selector(myBibleRecitationAction:)
              forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
