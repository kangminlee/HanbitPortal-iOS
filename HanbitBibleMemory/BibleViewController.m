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
@property (weak, nonatomic) IBOutlet UITextView *bibleKoreanText;
@property (weak, nonatomic) IBOutlet UITextField *bibleEnglishTitle;
@property (weak, nonatomic) IBOutlet UITextView *bibleEnglishText;

@end

@implementation BibleViewController

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

    // display bible verse
    self.bibleKoreanTitle.text  = self.koreanTitle;
    self.bibleKoreanText.text   = self.koreanText;
    self.bibleEnglishTitle.text = self.englishTitle;
    self.bibleEnglishText.text  = self.englishText;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
