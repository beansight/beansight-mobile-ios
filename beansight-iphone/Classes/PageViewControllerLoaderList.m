//
//  PageViewControllerLoaderList.m
//  ScrollingPages
//
//  Created by jb on 19/07/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PageViewControllerLoaderList.h"
#import "InsightListModel.h"
#import "PageViewControllerLoader.h"

static int PREDICTION_COUNT_TO_LOAD = 20;

@implementation PageViewControllerLoaderList

@synthesize scrollView, controllerLoaders;


- (BOOL) loadData:(BOOL)async
 callbackDelegate:(id)callbackDelegate 
 callbackFunction:(SEL)callbackFunction
{
	return [[InsightListModel getInstance] loadMoreInsight:PREDICTION_COUNT_TO_LOAD async:async callbackDelegate:callbackDelegate callbackFunction:callbackFunction];	
}


- (void) initWithPage: (int)initPage
{
	currentPageIndex = initPage;
	
	int page = initPage - 1;
	[self loadPage: page];
	
	page = initPage;
	[self loadPage: page ];
	
	page = initPage + 1;
	[self loadPage: page];
	
}


- (void) loadPage: (int)pageToLoad
{
	if (pageToLoad >= 0)
	{
		PageViewControllerLoader *ctr = [controllerLoaders objectAtIndex:pageToLoad];
		if (!ctr)
		{
			ctr = [[PageViewControllerLoader alloc] init];
			NSLog(@"sending pageIndex=%d", pageToLoad);
			[ctr setPageIndex:pageToLoad];
			[controllerLoaders replaceObjectAtIndex:pageToLoad withObject:ctr];
		}
		
		[ctr loadPageViewController:scrollView];
	}
}


- (void) unloadPage: (int)page 
{
	if (page >= 0)
	{
		[[controllerLoaders objectAtIndex:page] release];
	}
}


- (void) updateScrollViewSize {
    int size = [[[InsightListModel getInstance] insights] count];
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * size, scrollView.frame.size.height);
    
}

- (void) moveToNextPage
{
	[self unloadPage:currentPageIndex-1];
	[self loadPage:currentPageIndex+2];
	currentPageIndex++;
    
	// Si on a dèjà chargé la moitié les prédictions on lance le chargement de PREDICTION_COUNT_TO_LOAD/2 autres
    // Ne pas lancer le chargement s'il a déjà été lancé
	int loadedInsightsCount = [[InsightListModel getInstance].insights count];
	if (loadedInsightsCount <= currentPageIndex + PREDICTION_COUNT_TO_LOAD/2)
	{		
		[[InsightListModel getInstance] loadMoreInsight:(PREDICTION_COUNT_TO_LOAD/2) async:YES callbackDelegate:self callbackFunction:@selector(updateScrollViewSize)];
	}
}


- (void) moveToPreviousPage
{
	[self unloadPage:currentPageIndex+1];
	[self loadPage:currentPageIndex-2];
	currentPageIndex--;
}



- (void) dealloc
{
	[scrollView release];
	[controllerLoaders release];
	
	[super dealloc];
}


- (void)scrollViewDidScroll:(UIScrollView *)sender
{	
    // Switch the indicator when more than 50% of the previous/next page is visible
    CGFloat pageWidth = scrollView.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
 
	NSLog(@"moving from page %d to %d",currentPageIndex, page);
	
	if (currentPageIndex < page) 
	{
		[self moveToNextPage];
	} 
	else if (currentPageIndex > page)
	{
		[self moveToPreviousPage];
	}
	
}



@end
