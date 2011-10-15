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
#import "MBProgressHUD.h"

#define POPCORN_SECRET @"hcLcT5sWeUZ3Br7YmvhahFLGUw6tv6ERB5GbJT4qm8D"
#define POPCORN_CINEMAS_URL @"http://coocoorooza.com/api/afisha_theaters/%@/%@.json"
#define POPCORN_MOVIES_URL @"http://coocoorooza.com/api/afisha_cinemas/%@/%@.json"


@interface PCUDataController : NSObject <MBProgressHUDDelegate> {
    ASIHTTPRequest *request;
    MBProgressHUD *hudView;
    UIWindow *mainWindow;
}

- (void)startSyncData:(UIWindow *)window;
- (void)cleanupData;

@end
