//
//  InsightListModel.m
//  ScrollingPages
//
//  Created by jb on 19/07/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InsightListModel.h"
#import "InsightModel.h"
#import "ASIHTTPRequest.h"
#import "SBJson.h"

static InsightListModel *instance = nil;

@implementation InsightListModel

@synthesize insights;


+ (InsightListModel *) getInstance
{
	if (!instance)
	{
		instance = [[InsightListModel alloc] init];
	}
	return instance;
}

// TODO : je devrais mettre ça ailleurs
+ (NSString *) getHost {
	return @"http://92.243.10.157";
}

- (BOOL) loadMoreInsight:(int)count
{
	[self loadInsightsFrom: [insights count] number:count];
}

- (BOOL) loadInsightsFrom: (int)from number:(int)number
{
	NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
	NSString *access_token = [userDefaults objectForKey:@"access_token"];
	
	//NSString *fixeTxt = @"http://localhost:9000";
	NSString *apiTxt = [NSString stringWithFormat:@"/api/insights/list?access_token=%@&from=%d&number=%d&vote=non-voted", access_token, from, number];
	NSURL *url = [NSURL URLWithString: [NSString stringWithFormat:@"%@%@", [InsightListModel getHost], apiTxt]];
	ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
	//[request setDelegate:self];
	//[request startAsynchronous];
	[request startSynchronous];
	int statusCode = [request responseStatusCode];
	if (statusCode == 200)
	{
		[self requestFinished:request];
		return YES;
	} else if(statusCode == 403) {
		NSLog(@"error : %@",[[request error] description]);		
		return NO;
	} else {
		NSLog(@"error : %@",[[request error] description]);	
		return NO;
	}


	//[request release]; // ?
	
//	NSArray *loadedData = [NSArray arrayWithObjects:@"Page1", @"PAge2", @"PAge3", @"PAge4", @"Page5", @"PAge6", @"PAge7", @"PAge8", nil];	
//	for (NSString *content in loadedData) 
//	{
//		InsightModel *insight = [[InsightModel alloc] init];
//		insight.content = content;
//		[self.insights addObject:insight];
//		[insight release];
//	}
}


- (void)requestFinished:(ASIHTTPRequest *)request
{
	// Use when fetching text data
	NSString *responseString = [request responseString];
	
	NSDictionary *parser = [responseString JSONValue];
	NSArray *insightListJson = [parser objectForKey:@"response"];
	NSLog([NSString stringWithFormat:@"%d", [insightListJson count]]);
	
	NSDictionary *anInsight = [insightListJson objectAtIndex:0];
	NSString *aContent = [anInsight objectForKey:@"content"];
	NSLog(@"%@", aContent);
	
	for (NSDictionary *anInsightJson in insightListJson) 
	{
		InsightModel *insight = [InsightModel initWithContent: [anInsightJson objectForKey:@"content"] 
													insightId: [anInsightJson objectForKey:@"id"] 
												 endDate: [NSDate dateWithTimeIntervalSince1970: [[anInsightJson objectForKey:@"endDate"] doubleValue]/1000]
												   agreeCount: [[anInsightJson objectForKey:@"agreeCount"] integerValue]
												disagreeCount: [[anInsightJson objectForKey:@"disagreeCount"] integerValue]
										  lastCurrentUserVote: [anInsightJson objectForKey:@"lastCurrentUserVote"] ];
		[self.insights addObject:insight];
	}
	
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
	NSError *error = [request error];
}


- (NSMutableArray *) insights
{
	if (!insights)
	{
		insights = [[NSMutableArray alloc] init];
	}
	
	return insights;
}


- (InsightModel *) getInsight: (int)index {
	return [insights objectAtIndex:index];
}

- (void) dealloc
{
	[insights release];
	[super dealloc];
}


@end
