//
//  PCUDataController.m
//  Popcornua
//
//  Created by Alex on 9/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PCUDataController.h"

@implementation PCUDataController

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}


- (void) startSyncData{
    PCUSharedManager *myStoreManager = [PCUSharedManager sharedManager];
    NSError *error = nil;
    
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
    
    request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:@"http://coocoorooza.com/api/afisha_cinemas/1/hcLcT5sWeUZ3Br7YmvhahFLGUw6tv6ERB5GbJT4qm8D.json"]];
	[request setRequestMethod:@"GET"];
    [request addRequestHeader:@"User-Agent" value:[NSString stringWithFormat:@"iphone-app/%@",@"1.0"]];
    [request setTimeOutSeconds:60];
    [request setNumberOfTimesToRetryOnTimeout:3];
	[request startSynchronous];
    error = [request error];
    if (!error) {
        NSString *response = [request responseString];
        NSLog(@"Data: %@", response);
        //NSDictionary *json_data = [response JSONValue];
        /*
        NSArray *theaters = [json_data objectForKey:@"theaters"];

        for (NSDictionary *theater in theaters) {
            if ([Cinema createOrReplaceFromDictionary:theater withContext:myStoreManager.managedObjectContext]){
                //
            }
        }
        */
    }
    
    [myStoreManager release];
}

#pragma mark -
#pragma mark Dealloc

- (void)dealloc {
    [super dealloc];
}

@end
