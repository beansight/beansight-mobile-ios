//
//  UserAuthenticateDelegate.h
//  ScrollingPages
//
//  Created by jb on 27/07/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol UserAuthenticateDelegate

- (void) userDidAuthenticate: (NSString *)accessToken;

@end
