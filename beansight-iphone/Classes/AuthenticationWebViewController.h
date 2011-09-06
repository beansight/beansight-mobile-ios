//
//  AuthenticationWebViewController.h
//  ScrollingPages
//
//  Created by jb on 27/07/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AuthenticationWebViewController : UIViewController <UIWebViewDelegate> {
	IBOutlet UIWebView *myWebView;
	id userAuthenticationDelegate;
}

@property (nonatomic, retain) id userAuthenticationDelegate;
//@property (nonatomic, retain) IBOutlet UIWebView *webView;


@end
