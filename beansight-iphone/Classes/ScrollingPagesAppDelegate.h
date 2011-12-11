//
//  ScrollingPagesAppDelegate.h
//  ScrollingPages
//
//  Created by jb on 19/07/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ScrollingPagesViewController;

@interface ScrollingPagesAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    ScrollingPagesViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet ScrollingPagesViewController *viewController;
 
@end

