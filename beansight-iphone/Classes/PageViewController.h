//
//  PageViewController.h
//  ScrollingPages
//
//  Created by jb on 19/07/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PageViewController : UIViewController {
	UIScrollView *scrollView;
	int pageIndex;
	UILabel *endDate;
	UILabel *content;
	UIButton *agreeBtn;
	UIButton *disagreeBtn;
}

@property (nonatomic, retain) IBOutlet UILabel *endDate;
@property (nonatomic, retain) IBOutlet UILabel *content;

@property (nonatomic, retain) IBOutlet UIButton *agreeBtn;
@property (nonatomic, retain) IBOutlet UIButton *disagreeBtn;

- (id) loadPageView: (int)thePageIndex forTheScrollView:(UIScrollView *)theScrollView;

- (IBAction) agreeAction: (id)sender;
- (IBAction) disagreeAction: (id)sender;

@end
