IDTwitterAccountChooserViewController
=====================================

Twitter Account Chooser view controller for iOS 5+. Uses a block-based completion handler or a classic protocol-based delegate method.

## Why?
In iOS 5 and up you can store system-wide Twitter accounts. I looked for an existing Account chooser for when you have multiple accounts and I couldn't find one so I decided to make my own.

## What does it looks like?
![IDTwitterAccountChooserViewController](https://github.com/downloads/idevsoftware/IDTwitterAccountChooserViewController/screenshot.png)

It has a very basic look but it can be easily customized via standard UITableViewCell subclassing (or whatever your favorite method is).

## How does it works?

Copy and add the ```IDTwitterAccountChooserViewController.h``` and ```IDTwitterAccountChooserViewController.m``` files to your project, and make sure to link against the ```Twitter``` and ```Accounts``` frameworks.

In your own view controller implementation file (```.m```):

```
#import <Twitter/Twitter.h>
#import <Accounts/Accounts.h>
#import "IDTwitterAccountChooserViewController.h"

...

ACAccountStore *accountStore = [[ACAccountStore alloc] init];
ACAccountType *twitterAccountType = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
// check for access etc.
NSArray *twitterAccounts = [accountStore accountsWithAccountType:twitterAccountType];
if([twitterAccounts count] > 1) {
	// more than one account, use Chooser
	IDTwitterAccountChooserViewController *chooser = [[IDTwitterAccountChooserViewController alloc] init];
	[chooser setTwitterAccounts:twitterAccounts];
	[chooser setCompletionHandler:^(ACAccount *account) {
		// if user cancels the chooser then 'account' will be set to nil
		NSLog(@"account chosen: %@", account);
	}];
	[self presentModalViewController:chooser animated:YES];
}
```


If you'd rather use a protocol based delegation pattern instead of a completion handler block:

```
// make your view controller conform to the <IDTwitterAccountChooserViewControllerDelegate> protocol
@interface MyOwnViewController <IDTwitterAccountChooserViewControllerDelegate>

...

	[chooser setAccountChooserDelegate:self];

...

// implement the <IDTwitterAccountChooserViewControllerDelegate> method

#pragma mark - <IDTwitterAccountChooserViewControllerDelegate> Methods

- (void)twitterAccountChooserViewController:(IDTwitterAccountChooserViewController *)controller didChooseTwitterAccount:(ACAccount *)account {
		// if user cancels the chooser then 'account' will be set to nil
		NSLog(@"account chosen: %@", account);
}
```

If you set both a completion handler and a delegate, the former will be called while the later will be ignored.

## License

Licensed under the [MIT license](http://www.opensource.org/licenses/mit-license.php)

Copyright by [@iDevSoftware](http://idev.mobi/) 2012
