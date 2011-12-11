//
//  AgreeVote.m
//  ScrollingPages
//
//  Created by jb on 29/07/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AgreeVote.h"
#import "ASIHTTPRequest.h"
#import "SBJson.h"
#import "InsightListModel.h"

@implementation AgreeVote

+ (void) vote: (NSString *) uniqueId {
	NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
	NSString *access_token = [userDefaults objectForKey:@"access_token"];
	
	//NSString *fixeTxt = @"http://localhost:9000";
	NSString *apiTxt = [NSString stringWithFormat:@"/api/insights/agree?access_token=%@&id=%@", access_token, uniqueId];
	NSURL *url = [NSURL URLWithString: [NSString stringWithFormat:@"%@%@", [InsightListModel getHost], apiTxt]];
	ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
//	[request setDelegate:self];
//	[request startAsynchronous];
	[request startSynchronous];
	int statusCode = [request responseStatusCode];
	if (statusCode == 200)
	{
		// Use when fetching text data
		NSString *responseString = [request responseString];
		
		NSDictionary *parser = [responseString JSONValue];
		NSDictionary *voteResultJson = [parser objectForKey:@"response"];
		
		NSString *aVoteState = [voteResultJson objectForKey:@"voteState"];
		
		NSLog(@"voteState : %@", aVoteState);
		
		//return YES;
	} else if(statusCode == 403) {
		NSLog(@"error : %@",[[request error] description]);		
		//return NO;
	} else {
		NSLog(@"error : %@",[[request error] description]);	
		//return NO;
	}
}



- (void)requestFinished:(ASIHTTPRequest *)request
{
	// Use when fetching text data
	NSString *responseString = [request responseString];
	
	NSDictionary *parser = [responseString JSONValue];
	NSDictionary *voteResultJson = [parser objectForKey:@"response"];
		
	NSString *aVoteState = [voteResultJson objectForKey:@"voteState"];
	
	NSLog(@"voteState : %@", aVoteState);	
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
	NSLog(@"error : %@",[[request error] description]);		
}



@end
