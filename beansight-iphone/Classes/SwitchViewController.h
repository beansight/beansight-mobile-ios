//
//  SwitchViewController.h
//  ScrollingPages
//
//  Created by jb on 28/07/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScrollingPagesViewController.h"
#import "AuthenticationWebViewController.h"

@interface SwitchViewController : UIViewController {
	ScrollingPagesViewController *scrollingPagesViewController;
	AuthenticationWebViewController *authenticationWebViewController;
}

@property (nonatomic, retain) IBOutlet ScrollingPagesViewController *scrollingPagesViewController;
@property (nonatomic, retain) IBOutlet AuthenticationWebViewController *authenticationWebViewController;

@end
