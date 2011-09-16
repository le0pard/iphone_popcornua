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
    
    hudView.labelText = @"Updating cinemas";
    
    request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:@"http://coocoorooza.com/api/afisha_theaters/1/hcLcT5sWeUZ3Br7YmvhahFLGUw6tv6ERB5GbJT4qm8D.json"]];
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
    
    hudView.labelText = @"Updating movies";
    
    request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:@"http://coocoorooza.com/api/afisha_cinemas/1/hcLcT5sWeUZ3Br7YmvhahFLGUw6tv6ERB5GbJT4qm8D.json"]];
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
}



- (void)startSyncData:(UIWindow *)window{
    hudView = [[MBProgressHUD alloc] initWithWindow:window];
	[window addSubview:hudView];
	hudView.dimBackground = YES;	
	// Regiser for HUD callbacks so we can remove it from the window at the right time
    hudView.delegate = nil;
    hudView.labelText = @"Loading";
    hudView.detailsLabelText = @"updating main data";
    // Show the HUD while the provided method executes in a new thread
    [hudView showWhileExecuting:@selector(syncCoreData) onTarget:self withObject:nil animated:YES];
}

#pragma mark -
#pragma mark MBProgressHUDDelegate methods

- (void)hudWasHidden:(MBProgressHUD *)hud {
    // Remove HUD from screen when the HUD was hidded
    [hudView removeFromSuperview];
    [hudView release];
	hudView = nil;
}

#pragma mark -
#pragma mark Dealloc

- (void)dealloc {
    [super dealloc];
}

@end
