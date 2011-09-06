//
//  PageViewControllerLoader.h
//  ScrollingPages
//
//  Created by jb on 19/07/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PageViewController.h"

@interface PageViewControllerLoader : NSObject {
	int pageIndex;
	PageViewController *pageViewController;
}

@property (nonatomic, retain) PageViewController *pageViewController;

- (void) loadPageViewController: (UIScrollView *)theScrollView;
- (void) setPageIndex: (int)newPageIndex; 

@end
