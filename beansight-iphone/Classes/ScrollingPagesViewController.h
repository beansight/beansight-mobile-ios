//
//  ScrollingPagesViewController.h
//  ScrollingPages
//
//  Created by jb on 19/07/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserAuthenticateDelegate.h"

@interface ScrollingPagesViewController : UIViewController <UserAuthenticateDelegate> {
	UIScrollView *scrollView;
}

- (void) showAuthentication;

@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;

@end

