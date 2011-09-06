//
//  InsightListModel.h
//  ScrollingPages
//
//  Created by jb on 19/07/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InsightModel.h"

@interface InsightListModel : NSObject {
	NSMutableArray *insights;
}

@property (nonatomic, retain) NSMutableArray *insights;

- (BOOL) loadMoreInsight:(int)count;
- (BOOL) loadInsightsFrom: (int)from number:(int)number;
- (InsightModel *) getInsight: (int)index;

+ (InsightListModel *) getInstance;
+ (NSString *) getHost;


@end
