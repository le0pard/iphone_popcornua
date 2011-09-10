//
//  PCUDataController.h
//  Popcornua
//
//  Created by Alex on 9/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "Afisha.h"
#import "Cinema.h"
#import "Movie.h"
#import "PopcornuaAppDelegate.h"
#import "JSON.h"

@interface PCUDataController : NSObject {
    ASIHTTPRequest *request;
}

- (void) startSyncData;

@end
