//
//  PCUDataController.m
//  Popcornua
//
//  Created by Alex on 9/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PCUDataController.h"
#import <unistd.h>

@implementation PCUDataController

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}


- (void) syncCoreData{
    PCUSharedManager *myStoreManager = [PCUSharedManager sharedManager];
    NSError *error = nil;
    
    hudView.labelText = NSLocalizedString(@"Updating cinemas", @"");
    
    request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:POPCORN_CINEMAS_URL, 1, POPCORN_SECRET]]];
	[request setRequestMethod:@"GET"];
    [request addRequestHeader:@"User-Agent" value:[NSString stringWithFormat:@"iphone-app/%@",@"1.0"]];
    [request setTimeOutSeconds:60];
    [request setNumberOfTimesToRetryOnTimeout:3];
	[request startSynchronous];
    error = [request error];
    if (!error) {
        NSString *response = [request responseString];
        //NSLog(@"Data: %@", response);
        NSDictionary *json_data = [response JSONValue];
        NSArray *theaters = [json_data objectForKey:@"theaters"];
        
        for (NSDictionary *theater in theaters) {
            if ([Cinema createOrReplaceFromDictionary:theater withContext:myStoreManager.managedObjectContext]){
                //
            }
        }
        
    }
    
    hudView.labelText = NSLocalizedString(@"Updating movies", @"");
    
    request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:POPCORN_MOVIES_URL, 1, POPCORN_SECRET]]];
	[request setRequestMethod:@"GET"];
    [request addRequestHeader:@"User-Agent" value:[NSString stringWithFormat:@"iphone-app/%@",@"1.0"]];
    [request setTimeOutSeconds:60];
    [request setNumberOfTimesToRetryOnTimeout:3];
	[request startSynchronous];
    error = [request error];
    if (!error) {
        NSString *response = [request responseString];
        NSDictionary *json_data = [response JSONValue];
        NSArray *movies = [json_data objectForKey:@"cinemas"];
        for (NSDictionary *movie in movies) {
            if ([Movie createOrReplaceFromDictionary:movie withContext:myStoreManager.managedObjectContext]){
                //
            }
        }
        NSArray *afishas = [json_data objectForKey:@"afisha"];
        for (NSDictionary *afisha in afishas) {
            if ([Afisha createOrReplaceFromDictionary:afisha withContext:myStoreManager.managedObjectContext]){
                //
            }
        }
    }
    
    [myStoreManager release];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"updateTableViews" object:self];
}



- (void)startSyncData:(UIWindow *)window{
    mainWindow = window;
    hudView = [[MBProgressHUD alloc] initWithWindow:mainWindow];
	[mainWindow addSubview:hudView];
	hudView.dimBackground = YES;	
	// Regiser for HUD callbacks so we can remove it from the window at the right time
    hudView.delegate = nil;
    hudView.labelText = NSLocalizedString(@"Loading", @"");
    hudView.detailsLabelText = NSLocalizedString(@"updating program data", @"");
    hudView.removeFromSuperViewOnHide = true;
    // Show the HUD while the provided method executes in a new thread
    [hudView showWhileExecuting:@selector(syncCoreData) onTarget:self withObject:nil animated:YES];
}

#pragma mark -
#pragma mark MBProgressHUDDelegate methods

- (void)hudWasHidden:(MBProgressHUD *)hud {
    // Remove HUD from screen when the HUD was hidded
    [hudView release];
	hudView = nil;
}

#pragma mark -
#pragma mark Dealloc

- (void)dealloc {
    [super dealloc];
}

@end
