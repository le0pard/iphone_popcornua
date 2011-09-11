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
    //PopcornuaAppDelegate *appDelegate = (PopcornuaAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:@"http://coocoorooza.com/api/afisha_theaters/1/hcLcT5sWeUZ3Br7YmvhahFLGUw6tv6ERB5GbJT4qm8D.json"]];
	[request setRequestMethod:@"GET"];
    [request addRequestHeader:@"User-Agent" value:[NSString stringWithFormat:@"iphone-app/%@",@"1.0"]];
    [request setTimeOutSeconds:60];
    [request setNumberOfTimesToRetryOnTimeout:3];
	[request startSynchronous];
    NSError *error = [request error];
    if (!error) {
        NSString *response = [request responseString];
        NSLog(@"Data: %@", response);
        NSDictionary *json_data = [response JSONValue];
        NSArray *theaters = [json_data objectForKey:@"theaters"];
        for (NSDictionary *theater in theaters) {
            /*
            if ([[theater objectForKey:@"id"] isKindOfClass:[NSString class]]) {
                cinema.ext_id = [[theater objectForKey:@"id"] numericValue];
            } else {
                cinema.ext_id = [theater objectForKey:@"id"];
            }
            
            cinema.title = [theater objectForKey:@"title"];
            cinema.address = [theater objectForKey:@"address"];
            cinema.phone = [theater objectForKey:@"phone"];
            cinema.link = [theater objectForKey:@"link"];
            cinema.latitude = [theater objectForKey:@"latitude"];
            cinema.longitude = [theater objectForKey:@"longitude"];
            cinema.call_phone = [theater objectForKey:@"call_phone"];
            */
        }
    }
}

#pragma mark -
#pragma mark Dealloc

- (void)dealloc {
    [super dealloc];
}

@end
