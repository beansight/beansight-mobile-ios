//
//  PageViewControllerLoader.m
//  ScrollingPages
//
//  Created by jb on 19/07/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PageViewControllerLoader.h"
#import "PageViewController.h"

@implementation PageViewControllerLoader

@synthesize pageViewController;


- (void) loadPageViewController: (UIScrollView *)theScrollView
{
	if (!pageViewController)
	{
		pageViewController = [[PageViewController alloc] initWithNibName:@"PageViewController" bundle:nil];
		[pageViewController loadPageView:pageIndex forTheScrollView:theScrollView];
	}
}

- (void) setPageIndex: (int)newPageIndex 
{
	pageIndex = newPageIndex;
}


- (void) dealloc
{
	[pageViewController release];
	[super dealloc];
}


@end
