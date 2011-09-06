//
//  PageViewControllerLoaderList.h
//  ScrollingPages
//
//  Created by jb on 19/07/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface PageViewControllerLoaderList : NSObject <UIScrollViewDelegate> {
	UIScrollView *scrollView;
	int currentPageIndex;
	
	NSMutableArray *controllerLoaders;
}

@property (nonatomic, retain) UIScrollView *scrollView;


@property (nonatomic, retain) IBOutlet NSMutableArray *controllerLoaders;

- (BOOL) loadData;
- (void) initWithPage: (int)initPage;
- (void) moveToNextPage;
- (void) moveToPreviousPage;

- (void) loadPage: (int) pageToLoad;
- (void) unloadPage: (int)page;

@end
