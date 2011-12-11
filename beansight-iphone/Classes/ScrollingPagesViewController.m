//
//  ScrollingPagesViewController.m
//  ScrollingPages
//
//  Created by jb on 19/07/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ScrollingPagesViewController.h"
#import "PageViewControllerLoaderList.h"
#import "InsightListModel.h"
#import "AuthenticationWebViewController.h"

@implementation ScrollingPagesViewController

@synthesize scrollView;



/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {	

	
	// a page is the width of the scroll view
    scrollView.pagingEnabled = YES;
	scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.scrollsToTop = NO;
    scrollView.delegate = [[PageViewControllerLoaderList alloc] init];
	((PageViewControllerLoaderList *) scrollView.delegate).scrollView = scrollView;
		


}

- (void)viewDidAppear:(BOOL)animated {
	[self initFirstDisplay];
	/*
	NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
	NSString *userAccessToken = [userDefaults objectForKey:@"accessToken"];
	if (!userAccessToken) 
	{
		[self showAuthentication];
	}
	else {
		[self initFirstDisplay];
	}
	 */

}



- (void) showAuthentication {
	AuthenticationWebViewController *authenticationController = [[[AuthenticationWebViewController alloc] initWithNibName:@"AuthenticationWebViewController" bundle:nil] autorelease];
	authenticationController.userAuthenticationDelegate = self;
	//UINavigationController *navigationController = [[UINavigationController alloc]
	//												initWithRootViewController:authenticationController];
	[self presentModalViewController:authenticationController animated:YES];
	// quand faut-il les relacher ? parce que là si je release juste après ... BOUM
	//[navigationController release];
	//[authenticationController release];
}

- (void) initFirstDisplay {
	BOOL authenticated = [((PageViewControllerLoaderList *) scrollView.delegate) loadData:NO]; 
	if (!authenticated) {
		[self showAuthentication];
	} else {
	
		int size = [[[InsightListModel getInstance] insights] count];
	
		id scrollViewDelegateTmp = scrollView.delegate;
		scrollView.delegate = nil;
		scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * size, scrollView.frame.size.height);
		scrollView.contentOffset = CGPointMake(0, 0);
		scrollView.delegate = scrollViewDelegateTmp;
		
		[((PageViewControllerLoaderList *) scrollView.delegate) initWithPage:0]; 
	}
}


- (void) userDidAuthenticate: (NSString *) accessToken {
	NSLog(@"userDidAuthenticate called in ScrollingPagesViewController with accessToken=%@", accessToken);
	NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
	[userDefaults setObject:accessToken forKey:@"access_token"];
	[userDefaults synchronize];
	
	[self initFirstDisplay];
	[self dismissModalViewControllerAnimated:YES];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

@end
