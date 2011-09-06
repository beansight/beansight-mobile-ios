//
//  InsightModel.m
//  ScrollingPages
//
//  Created by jb on 19/07/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "InsightModel.h"


@implementation InsightModel


@synthesize insightId, content, endDate, agreeCount, disagreeCount, lastCurrentUserVote;

- (void) dealloc
{
	[insightId release];
	[content release];
	[lastCurrentUserVote release];
	[super dealloc];
}

+ (id) initWithContent: (NSString *)content 
			 insightId: (NSString *) insightId 
			   endDate: (NSDate *)endDate
			agreeCount: (int) agreeCount 
		 disagreeCount:(int)disagreeCount 
   lastCurrentUserVote:(NSString *)lastCurrentUserVote {
	
	InsightModel *insight = [[[InsightModel alloc] init] autorelease];
	insight.content = content;
	insight.endDate = endDate;
	insight.insightId = insightId;
	insight.agreeCount = agreeCount;
	insight.disagreeCount = disagreeCount;
	insight.lastCurrentUserVote = lastCurrentUserVote;
	
	return insight;
}

- (int) getVoteStatus {
	if ([lastCurrentUserVote isEqualToString:@"agree"]) {
		return 1;
	} else if ([lastCurrentUserVote isEqualToString:@"disagree"]) {
		return -1;
	} else if ([lastCurrentUserVote isEqualToString:@"non-voted"]) {
		return 0;
	}
}

- (void)setVoteStatus:(int)voteStatus {
	if (voteStatus == 1) {
		self.lastCurrentUserVote = @"agree";
	} else if (voteStatus == -1) {
		self.lastCurrentUserVote = @"disagree";
	} else if (voteStatus == 0) {
		self.lastCurrentUserVote = @"non-voted";
	}
}

@end
