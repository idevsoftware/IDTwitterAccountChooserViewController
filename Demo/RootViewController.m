//
//  RootViewController.m
//  Demo
//
//  Created by Carlos Oliva on 11-12-12.
//  Copyright (c) 2012 iDev Software. All rights reserved.
//

#import <Twitter/Twitter.h>
#import <Accounts/Accounts.h>
#import "RootViewController.h"
#import "IDTwitterAccountChooserViewController.h"

@interface RootViewController ()

@property (nonatomic, strong, readwrite) UIButton *chooseButton;

@end

@implementation RootViewController

@synthesize chooseButton;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)loadView {
	self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	self.view.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
	self.view.autoresizesSubviews = YES;
	self.view.backgroundColor = [UIColor darkGrayColor];
	
	[self.view addSubview:self.chooseButton];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewDidUnload {
	[super viewDidUnload];
	self.chooseButton = nil;
}


#pragma mark - Button Actions


- (IBAction)chooseButtonTouched:(id)sender {
	ACAccountStore *accountStore = [[ACAccountStore alloc] init];
	ACAccountType *twitterAccountType = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
	[accountStore
	 requestAccessToAccountsWithType:twitterAccountType
	 withCompletionHandler:^(BOOL granted, NSError *error) {
		 // the completion handler isn't guaranteed to run on any particular thread
		 dispatch_async(dispatch_get_main_queue(), ^{
			 if(granted) {
				 NSArray *twitterAccounts = [accountStore accountsWithAccountType:twitterAccountType];
				 NSInteger count = [twitterAccounts count];
				 switch(count) {
					 case 0:
					 {
						 // No twitter Accounts have been setup
						 UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"No Twitter Accounts", @"No Twitter Accounts")
																			 message:NSLocalizedString(@"You haven't setup a Twitter account yet. Please add one by going through the Settings App > Twitter", @"You haven't setup a Twitter account yet. Please add one by going through the Settings App > Twitter")
																			delegate:nil
																   cancelButtonTitle:NSLocalizedString(@"Dismiss", @"Dismiss")
																   otherButtonTitles:nil];
						 [alertView show];
					 }
						 break;
						 
					 case 1:
					 {
						 // A single Twitter account, use that
						 ACAccount *account = [twitterAccounts lastObject];
						 UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:[account accountDescription]
																			 message:NSLocalizedString(@"Only a single account is setup", @"Only a single account is setup")
																			delegate:nil
																   cancelButtonTitle:NSLocalizedString(@"Dismiss", @"Dismiss")
																   otherButtonTitles:nil];
						 [alertView show];
					 }
						 break;
						 
					 default:
					 {
						 // More than one Twitter account - show chooser
						 IDTwitterAccountChooserViewController *chooser = [[IDTwitterAccountChooserViewController alloc] init];
						 [chooser setTwitterAccounts:twitterAccounts];
						 [chooser setCompletionHandler:^(ACAccount *account) {
							 if(account != nil) {
								 UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:[account accountDescription]
																					 message:[NSString stringWithFormat:NSLocalizedString(@"The %@ account was chosen", @"The %@ account was chosen"), [account accountDescription]]
																					delegate:nil
																		   cancelButtonTitle:NSLocalizedString(@"Dismiss", @"Dismiss")
																		   otherButtonTitles:nil];
								 [alertView show];
							 }
						 }];
						 [self presentModalViewController:chooser animated:YES];
					 }
						 break;
				 }
			 } else {
				 UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"No Access to Twitter", @"No Access to Twitter")
																	 message:NSLocalizedString(@"To sign in with Twitter the App requires access to your Twitter Accounts. Please grant access through the Settings App and going to Twitter", @"To sign in with Twitter the App requires access to your Twitter Accounts. Please grant access through the Settings App and going to Twitter")
																	delegate:nil
														   cancelButtonTitle:NSLocalizedString(@"Dismiss", @"Dismiss")
														   otherButtonTitles:nil];
				 [alertView show];
			 }
		 });
	 }
	 ];
}


#pragma mark - Getter Methods


- (UIButton *)chooseButton {
	if(chooseButton == nil) {
		chooseButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
		[chooseButton setBackgroundColor:self.view.backgroundColor];
		[chooseButton setTitle:NSLocalizedString(@"Choose Twitter Account", @"Choose Twitter Account") forState:UIControlStateNormal];
		[chooseButton setAutoresizingMask:(UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleRightMargin)];
		[chooseButton sizeToFit];
		[chooseButton setCenter:self.view.center];
		[chooseButton addTarget:self action:@selector(chooseButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
	}
	return chooseButton;
}


@end
