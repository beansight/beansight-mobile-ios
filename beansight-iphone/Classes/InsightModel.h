//
//  InsightModel.h
//  ScrollingPages
//
//  Created by jb on 19/07/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface InsightModel : NSObject {
	NSString *insightId;
	NSString *content;
	NSDate *endDate;
	int agreeCount;
	int disagreeCount;
	NSString *lastCurrentUserVote;
	int voteStatus; // 1=agree 0=note voted -1=disagree
}

@property (nonatomic, retain) NSString *insightId;
@property (nonatomic, retain) NSString *content;
@property (nonatomic, retain) NSDate *endDate;
@property int agreeCount;
@property int disagreeCount;	
@property int voteStatus;
@property (nonatomic, retain) NSString *lastCurrentUserVote;

+ (id) initWithContent: (NSString *)content 
			 insightId: (NSString *) insightId 
			   endDate: (NSDate *)endDate
			agreeCount: (int) agreeCount 
		 disagreeCount:(int)disagreeCount
   lastCurrentUserVote:(NSString *)lastCurrentUserVote;

- (int) getVoteStatus;
- (void)setVoteStatus:(int)voteStatus;

@end
