//
//  PCUDataController.h
//  Popcornua
//
//  Created by Alex on 9/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "Afisha.h"
#import "Cinema.h"
#import "Movie.h"
#import "JSON.h"
#import "PCUSharedManager.h"
#import "MBProgressHUD.h"

@interface PCUDataController : NSObject <MBProgressHUDDelegate> {
    ASIHTTPRequest *request;
    MBProgressHUD *hudView;
}

- (void)startSyncData:(UIWindow *)window;

@end
