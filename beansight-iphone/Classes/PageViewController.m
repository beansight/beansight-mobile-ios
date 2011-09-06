//
//  PageViewController.m
//  ScrollingPages
//
//  Created by jb on 19/07/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PageViewController.h"
#import "InsightListModel.h"
#import "AuthenticationWebViewController.h"
#import "AgreeVote.h"
#import "DisagreeVote.h"

@implementation PageViewController

@synthesize content, endDate, agreeBtn, disagreeBtn;

- (id)loadPageView: (int)thePageIndex forTheScrollView:(UIScrollView *)theScrollView
{
	if (self = [super initWithNibName:@"PageViewController" bundle:nil])
	{		
		pageIndex = thePageIndex;
		
		NSLog(@"loadPageView : thePageIndex=%d and pageIndex=%d", thePageIndex, pageIndex);
		
        CGRect frame = theScrollView.frame;
        frame.origin.x = frame.size.width * pageIndex;
        frame.origin.y = 0;
        self.view.frame = frame;
        [theScrollView addSubview:self.view];
	}
	return self;
}


- (IBAction) agreeAction: (UIButton *)button 
{
	NSLog(@"agreeAction");
	[self setInsightState: 1];
	InsightModel *insight = [[InsightListModel getInstance] getInsight:pageIndex];
	[insight setVoteStatus:1];
	[DisagreeVote vote:insight.insightId];
	[AgreeVote vote:insight.insightId];
}

- (IBAction) disagreeAction: (UIButton *)button 
{
	NSLog(@"disagreeAction");
	[self setInsightState: -1];
	InsightModel *insight = [[InsightListModel getInstance] getInsight:pageIndex];
	[insight setVoteStatus:-1];
	[DisagreeVote vote:insight.insightId];
}

- (void) setInsightState: (int)state {
	switch (state) {
		case 1:
			NSLog(@"setInsightState agree");
			[self setAgreeBtnToSelected];
			[self setDisagreeBtnToNormal];
			break;
		case -1:
			NSLog(@"setInsightState disagree");
			[self setDisagreeBtnToSelected];
			[self setAgreeBtnToNormal];
			break;
		case 0:
			NSLog(@"setInsightState none");
			[self setAgreeBtnToNormal];
			[self setDisagreeBtnToNormal];
			break;			
		default:
			break;
	}
}

- (void) setAgreeBtnToSelected {
	UIImage *buttonImage = [UIImage imageNamed:@"button-agree-highlight.png"];
	[agreeBtn setBackgroundImage:buttonImage forState:UIControlStateNormal];
	[buttonImage release];
}

- (void) setAgreeBtnToNormal {
	UIImage *buttonImage = [UIImage imageNamed:@"button.png"];
	[agreeBtn setBackgroundImage:buttonImage forState:UIControlStateNormal];
	[buttonImage release];
}

- (void) setDisagreeBtnToSelected {
	UIImage *buttonImage = [UIImage imageNamed:@"button-disagree-highlight.png"];
	[disagreeBtn setBackgroundImage:buttonImage forState:UIControlStateNormal];
	[buttonImage release];
}

- (void) setDisagreeBtnToNormal {
	UIImage *buttonImage = [UIImage imageNamed:@"button.png"];
	[disagreeBtn setBackgroundImage:buttonImage forState:UIControlStateNormal];
	[buttonImage release];
}

- (void)viewDidLoad {
	NSLog(@"using %d to load content", pageIndex);
	content.text = [[InsightListModel getInstance] getInsight:pageIndex].content;
	[content alignTop];
	
	NSLocale *locale = [NSLocale currentLocale];
	NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease]; 
	NSString *dateFormat = [NSDateFormatter dateFormatFromTemplate:@"MMM d yyyy" options:0 locale:locale];
	[dateFormatter setDateFormat:dateFormat];
	[dateFormatter setLocale:locale];
	
	NSString *formatedDate = [dateFormatter stringFromDate:[[InsightListModel getInstance] getInsight:pageIndex].endDate]; 
	endDate.text = [NSString stringWithFormat:@"%@ %@", @"On", formatedDate];

	InsightModel *insight = [[InsightListModel getInstance] getInsight:pageIndex];
	[self setInsightState: [insight getVoteStatus]];
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[content release];
	[endDate release];
	[agreeBtn release];
	[disagreeBtn release];
    [super dealloc];
}


@end
