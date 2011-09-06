//
//  AuthenticationWebViewController.m
//  ScrollingPages
//
//  Created by jb on 27/07/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AuthenticationWebViewController.h"
#import "InsightListModel.h"

@implementation AuthenticationWebViewController

@synthesize userAuthenticationDelegate;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	//webView.delegate = self;
	NSString *urlString = [NSString stringWithFormat:@"%@/api/authenticate", [InsightListModel getHost]];
    [myWebView loadRequest: [NSURLRequest requestWithURL: [NSURL URLWithString:urlString]] ];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[myWebView release];
    [super dealloc];
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
	NSLog(@"webViewDidStartLoad : %@", [[[myWebView request] URL] absoluteString]);
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
	NSString *urlString = [[[myWebView request] URL] absoluteString];
	NSLog(@"webViewDidFinishLoad : %@", urlString);
	NSString *extractedAccessToken = [urlString substringFromIndex:NSMaxRange([urlString rangeOfString:@"access_token"]) + 1 ];
	NSLog(@"%@", extractedAccessToken);
	
	[userAuthenticationDelegate userDidAuthenticate: extractedAccessToken];
}


@end
