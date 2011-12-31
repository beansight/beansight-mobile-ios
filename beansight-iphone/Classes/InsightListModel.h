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
    id callbackDelegate;
	SEL callbackFunction;
}

@property (nonatomic, retain) id callbackDelegate;
@property (nonatomic) SEL callbackFunction;
@property (nonatomic, retain) NSMutableArray *insights;

- (BOOL) loadMoreInsight:(int)count 
                   async:(BOOL)async 
        callbackDelegate:(id)callbackDelegate 
        callbackFunction:(SEL)callbackFunction;

- (BOOL) loadInsightsFrom: (int)from number:(int)number async:(BOOL)async;
- (InsightModel *) getInsight: (int)index;

+ (InsightListModel *) getInstance;
+ (NSString *) getHost;


@end
