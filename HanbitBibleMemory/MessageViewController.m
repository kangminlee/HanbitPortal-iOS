//
//  MessageViewController.m
//  HanbitBibleMemory
//
//  Created by Jaehong Chon on 2/23/14.
//  Copyright (c) 2014 Hanbit Church. All rights reserved.
//

#import <MessageUI/MessageUI.h>
#import "MessageViewController.h"
#import "SWRevealViewController.h"

@interface MessageViewController () <MFMailComposeViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (weak, nonatomic) IBOutlet UILabel *feedbackMessage;

@end

@implementation MessageViewController

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
    
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
	self.feedbackMessage.hidden = YES;
    self.feedbackMessage.text = @"";
    
    [self displayMailComposerSheet];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// -------------------------------------------------------------------------------
//	displayMailComposerSheet
//  Displays an email composition interface inside the application.
//  Populates all the Mail fields.
// -------------------------------------------------------------------------------
- (void)displayMailComposerSheet
{
	MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
	picker.mailComposeDelegate = self;
	
	[picker setSubject:@""];
	
	// Set up recipients
	NSArray *toRecipients = [NSArray arrayWithObject:@"apple@sdhanbit.org"];
	//NSArray *ccRecipients = [NSArray arrayWithObjects:@"second@example.com", @"third@example.com", nil];
	//NSArray *bccRecipients = [NSArray arrayWithObject:@"fourth@example.com"];
	
	[picker setToRecipients:toRecipients];
	//[picker setCcRecipients:ccRecipients];
	//[picker setBccRecipients:bccRecipients];
	
	// Attach an image to the email
	//NSString *path = [[NSBundle mainBundle] pathForResource:@"rainy" ofType:@"jpg"];
	//NSData *myData = [NSData dataWithContentsOfFile:path];
	//[picker addAttachmentData:myData mimeType:@"image/jpeg" fileName:@"rainy"];
	
	// Fill out the email body text
	NSString *emailBody = @"";
	[picker setMessageBody:emailBody isHTML:NO];
	
	[self presentViewController:picker animated:YES completion:NULL];
}

#pragma mark - Delegate Methods

// -------------------------------------------------------------------------------
//	mailComposeController:didFinishWithResult:
//  Dismisses the email composition interface when users tap Cancel or Send.
//  Proceeds to update the message field with the result of the operation.
// -------------------------------------------------------------------------------
- (void)mailComposeController:(MFMailComposeViewController*)controller
          didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
	self.feedbackMessage.hidden = NO;
    
	// Notifies users about errors associated with the interface
	switch (result)
	{
		case MFMailComposeResultCancelled:
			self.feedbackMessage.text = @"의견 메일 전송이 취소되었습니다.";
			break;
		case MFMailComposeResultSaved:
			self.feedbackMessage.text = @"의견 메일이 저장되었습니다.\n시간되실 때 발송해 주십시요.";
			break;
		case MFMailComposeResultSent:
			self.feedbackMessage.text = @"감사합니다.\n의견 메일이 성공적으로 발송되었습니다.";
			break;
		case MFMailComposeResultFailed:
			self.feedbackMessage.text = @"의견 메일 전송이 실패했습니다.";
			break;
		default:
			self.feedbackMessage.text = @"의견 메일이 전송되지 않았습니다.";
        break;
	}
    
	[self dismissViewControllerAnimated:YES completion:NULL];
}

@end
