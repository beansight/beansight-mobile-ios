//
//  DisagreeVote.m
//  ScrollingPages
//
//  Created by jb on 29/07/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DisagreeVote.h"
#import "ASIHTTPRequest.h"
#import "InsightListModel.h"

@implementation DisagreeVote

+ (void) vote: (NSString *) uniqueId {
	NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
	NSString *access_token = [userDefaults objectForKey:@"access_token"];
	
	//NSString *fixeTxt = @"http://localhost:9000";
	NSString *apiTxt = [NSString stringWithFormat:@"/api/insights/disagree?access_token=%@&id=%@", access_token, uniqueId];
	NSURL *url = [NSURL URLWithString: [NSString stringWithFormat:@"%@%@", [InsightListModel getHost], apiTxt]];
	ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
	//[request setDelegate:self];
	[request startAsynchronous];
}

@end
