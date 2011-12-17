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
    BOOL isLoadOnGoing;
}

@property (nonatomic, retain) NSMutableArray *insights;

- (BOOL) loadMoreInsight:(int)count async:(BOOL)async;
- (BOOL) loadInsightsFrom: (int)from number:(int)number async:(BOOL)async;
- (InsightModel *) getInsight: (int)index;

+ (InsightListModel *) getInstance;
+ (NSString *) getHost;


@end
